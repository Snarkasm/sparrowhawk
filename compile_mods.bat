@echo off
set "CLANG_EXE=clang++"
where clang++ >nul 2>nul
if %errorlevel% neq 0 (
    if exist "C:\Program Files\Windhawk\Compiler\bin\clang++.exe" (
        set "CLANG_EXE=C:\Program Files\Windhawk\Compiler\bin\clang++.exe"
    ) else (
        echo clang++.exe not found in PATH or standard Windhawk Compiler directory.
        echo Please install MinGW/Clang compiler to recompile mods.
        exit /b 1
    )
)

set "INCLUDE_PATH=%~dp0src\windhawk\engine"
if exist "C:\Program Files\Windhawk\Compiler\include" (
    set "INCLUDE_PATH=C:\Program Files\Windhawk\Compiler\include"
)

echo Compiling Taskbar Clock Customization mod...
"%CLANG_EXE%" -std=c++23 -O2 -shared -static-libgcc -static-libstdc++ -DUNICODE -D_UNICODE -DWINVER=0x0A00 -D_WIN32_WINNT=0x0A00 -D_WIN32_IE=0x0A00 -DNTDDI_VERSION=0x0A000008 -D__USE_MINGW_ANSI_STDIO=0 -DWH_MOD "-DWH_MOD_ID=L\"taskbar-clock-customization\"" "-DWH_MOD_VERSION=L\"1.8\"" -DWH_WINDHAWK_VERSION=0x01050100 -I"%INCLUDE_PATH%" "%~dp0src\windhawk\Release\64\windhawk.lib" -x c++ "%~dp0dist\AppData\ModsSource\taskbar-clock-customization.wh.cpp" -include windhawk_api.h -target x86_64-w64-mingw32 -Wl,--export-all-symbols -o "%~dp0dist\AppData\Mods\64\taskbar-clock-customization.dll" -ldxgi -lole32 -loleaut32 -lpdh -lpowrprof -lruntimeobject -lshlwapi -lversion -lwininet || goto fail

echo Compiling Vertical Taskbar mod...
"%CLANG_EXE%" -std=c++23 -O2 -shared -static-libgcc -static-libstdc++ -DUNICODE -D_UNICODE -DWINVER=0x0A00 -D_WIN32_WINNT=0x0A00 -D_WIN32_IE=0x0A00 -DNTDDI_VERSION=0x0A000008 -D__USE_MINGW_ANSI_STDIO=0 -DWH_MOD "-DWH_MOD_ID=L\"taskbar-vertical\"" "-DWH_MOD_VERSION=L\"1.3.13\"" -DWH_WINDHAWK_VERSION=0x01050100 -I"%INCLUDE_PATH%" "%~dp0src\windhawk\Release\64\windhawk.lib" -x c++ "%~dp0dist\AppData\ModsSource\taskbar-vertical.wh.cpp" -include windhawk_api.h -target x86_64-w64-mingw32 -Wl,--export-all-symbols -o "%~dp0dist\AppData\Mods\64\taskbar-vertical.dll" -ldwmapi -lole32 -loleaut32 -lruntimeobject -lshcore -lversion || goto fail

echo All mods compiled successfully!
exit /b 0

:fail
echo Mod compilation failed!
exit /b 1
