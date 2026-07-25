@ECHO OFF

REM // Usage:
REM // build.bat Debug ""
REM // build.bat Release :rebuild

SET "VSCMD_START_DIR=%CD%"
SET "VSINSTALLDIR="
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (
    FOR /F "usebackq tokens=*" %%i IN (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) DO (
        SET "VSINSTALLDIR=%%i"
    )
)

IF NOT "%VSINSTALLDIR%"=="" IF EXIST "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvars64.bat" (
    CALL "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvars64.bat"
) ELSE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    CALL "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
) ELSE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
    CALL "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
)

if exist "%~dp0nuget.exe" (
    "%~dp0nuget.exe" restore "%~dp0windhawk.sln"
) else (
    where nuget >nul 2>nul && nuget restore "%~dp0windhawk.sln"
)

MSBuild.exe "%~dp0windhawk.sln" /m /t:"app%~2" /p:Configuration="%~1" /p:Platform="Win32" || GOTO fail
MSBuild.exe "%~dp0windhawk.sln" /m /t:"engine%~2" /p:Configuration="%~1" /p:Platform="Win32" || GOTO fail
MSBuild.exe "%~dp0windhawk.sln" /m /t:"engine%~2" /p:Configuration="%~1" /p:Platform="x64" || GOTO fail
MSBuild.exe "%~dp0windhawk.sln" /m /t:"engine%~2" /p:Configuration="%~1" /p:Platform="ARM64"

REM // Done
EXIT /b 0

:fail
EXIT /b %ERRORLEVEL%
