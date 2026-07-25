#include "stdafx.h"

#include "engine_control.h"

#include "logger.h"
#include "storage_manager.h"

EngineControl::EngineControl() {
    auto engineLibraryPath =
        StorageManager::GetInstance().GetEnginePath() / L"windhawk.dll";

    LOG(L"EngineControl: Loading engine library from %ls...", engineLibraryPath.c_str());

    engineModule.reset(LoadLibrary(engineLibraryPath.c_str()));
    THROW_LAST_ERROR_IF_NULL_MSG(
        engineModule,
        "Failed to load engine library: %ls, make sure that the engine path "
        "that's specified in sparrowhawk.ini is correct",
        engineLibraryPath.c_str());

    LOG(L"EngineControl: Engine library loaded successfully.");

    pGlobalHookSessionStart = reinterpret_cast<GLOBAL_HOOK_SESSION_START>(
        GetProcAddress(engineModule.get(), "GlobalHookSessionStart"));
    THROW_LAST_ERROR_IF_NULL(pGlobalHookSessionStart);

    pGlobalHookSessionHandleNewProcesses =
        reinterpret_cast<GLOBAL_HOOK_SESSION_HANDLE_NEW_PROCESSES>(
            GetProcAddress(engineModule.get(),
                           "GlobalHookSessionHandleNewProcesses"));
    THROW_LAST_ERROR_IF_NULL(pGlobalHookSessionHandleNewProcesses);

    pGlobalHookSessionEnd = reinterpret_cast<GLOBAL_HOOK_SESSION_END>(
        GetProcAddress(engineModule.get(), "GlobalHookSessionEnd"));
    THROW_LAST_ERROR_IF_NULL(pGlobalHookSessionEnd);

    LOG(L"EngineControl: Calling GlobalHookSessionStart()...");
    hGlobalHookSession = pGlobalHookSessionStart();
    if (!hGlobalHookSession) {
        LOG(L"EngineControl: GlobalHookSessionStart() returned NULL!");
        throw std::runtime_error("Failed to start the global hooking session");
    }
    LOG(L"EngineControl: GlobalHookSessionStart() succeeded (session handle=%p)", hGlobalHookSession);
}

EngineControl::~EngineControl() {
    LOG(L"EngineControl: Destructing session...");
    pGlobalHookSessionEnd(hGlobalHookSession);
}

BOOL EngineControl::HandleNewProcesses() {
    BOOL res = pGlobalHookSessionHandleNewProcesses(hGlobalHookSession);
    LOG(L"EngineControl: HandleNewProcesses() returned %d", res);
    return res;
}
