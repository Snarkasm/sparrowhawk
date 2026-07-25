@echo off
echo Building Sparrowhawk Release binaries...
cd /d "%~dp0src\windhawk"
call build.bat Release
if %errorlevel% neq 0 (
    echo Build failed!
    exit /b %errorlevel%
)

cd /d "%~dp0"
echo Verifying Inno Setup Compiler...
where ISCC >nul 2>nul
if %errorlevel% equ 0 (
    echo Compiling Sparrowhawk-Setup.exe with ISCC...
    ISCC sparrowhawk.iss
) else if exist "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe" (
    echo Compiling Sparrowhawk-Setup.exe with Inno Setup 6...
    "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe" sparrowhawk.iss
) else if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    echo Compiling Sparrowhawk-Setup.exe with Inno Setup 6...
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" sparrowhawk.iss
) else (
    echo ISCC.exe not found in PATH or standard location.
    echo Please open sparrowhawk.iss in Inno Setup Compiler to build Sparrowhawk-Setup.exe.
)
