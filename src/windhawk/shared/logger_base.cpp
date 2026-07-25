#include "stdafx.h"

#include "logger_base.h"

LoggerBase::LoggerBase(Verbosity initialVerbosity)
    : m_verbosity(initialVerbosity) {}

void LoggerBase::SetVerbosity(Verbosity verbosity) {
    m_verbosity = verbosity;
}

LoggerBase::Verbosity LoggerBase::GetVerbosity() {
    return m_verbosity;
}

void LoggerBase::VLogLine(PCWSTR format, va_list args) {
    WCHAR buffer[1025];
    int len = _vsnwprintf_s(buffer, _TRUNCATE, format, args);
    if (len == -1) {
        // Truncation occurred.
        len = _countof(buffer) - 1;
    }

    while (--len >= 0 && buffer[len] == L'\n') {
        // Skip all newlines at the end.
    }

    // Leave only a single trailing newline.
    if (buffer[len + 1] == L'\n' && buffer[len + 2] == L'\n') {
        buffer[len + 2] = L'\0';
    }

    OutputDebugString(buffer);

    static bool logToFile = []() {
        auto checkEnv = [](PCWSTR varName) {
            WCHAR buf[32];
            DWORD size = GetEnvironmentVariableW(varName, buf, _countof(buf));
            if (size > 0 && size < _countof(buf)) {
                if (_wcsicmp(buf, L"1") == 0 || _wcsicmp(buf, L"true") == 0) {
                    return true;
                }
            }
            return false;
        };
        return checkEnv(L"SPARROWHAWK_LOG") || checkEnv(L"WINDHAWK_LOG") || checkEnv(L"WINDHAWK_DEBUG");
    }();

    if (logToFile) {
        WCHAR tempPath[MAX_PATH];
        if (GetTempPathW(MAX_PATH, tempPath) > 0) {
            std::wstring logFilePath = std::wstring(tempPath) + L"sparrowhawk.log";
            FILE* f = nullptr;
            if (_wfopen_s(&f, logFilePath.c_str(), L"ab, ccs=UTF-8") == 0 && f) {
                SYSTEMTIME st;
                GetLocalTime(&st);
                DWORD pid = GetCurrentProcessId();
                WCHAR exePath[MAX_PATH] = L"";
                GetModuleFileNameW(nullptr, exePath, MAX_PATH);
                PCWSTR exeName = wcsrchr(exePath, L'\\');
                exeName = exeName ? exeName + 1 : exePath;
                fwprintf(f, L"[%02d:%02d:%02d.%03d] [%ls PID:%u] %s\n", st.wHour,
                        st.wMinute, st.wSecond, st.wMilliseconds, exeName, pid,
                        buffer);
                fclose(f);
            }
        }
    }
}

void LoggerBase::LogLine(PCWSTR format, ...) {
    va_list args;
    va_start(args, format);
    VLogLine(format, args);
    va_end(args);
}
