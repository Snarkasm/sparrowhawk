# Sparrowhawk v1.0.0 — Technical & Security Audit Briefing 🔒

**Target Audience**: IT Security, Endpoint Protection, and System Administration Teams  
**Document Status**: Fact-Based Technical Security Overview  
**Repository**: [github.com/Snarkasm/sparrowhawk](https://github.com/Snarkasm/sparrowhawk)  
**License**: GNU General Public License v3.0 (GPL-3.0)  

---

## Executive Summary

**Sparrowhawk** is an offline-focused, non-elevated Windows taskbar customization utility based on the open-source [Windhawk](https://windhawk.net/) engine architecture (created by Ramen Software / m417z). 

It is specifically modified and packaged to operate within strict enterprise and workstation environments that enforce **zero administrator privileges**, **no service or driver installations**, and **minimal system footprint**.

---

## Core Security Controls & Technical Verification

### 1. Privilege Boundaries (`AsInvoker` Execution)
* **No Administrative Elevation**: The executable manifest enforces `<requestedExecutionLevel level="asInvoker" uiAccess="false"/>`.
* **Standard User Scope**: Installs to `%LOCALAPPDATA%\Sparrowhawk` and runs strictly within the logged-in user's unprivileged execution context.
* **Zero Kernel / Service Footprint**: Sparrowhawk does **not** install system services, kernel drivers, or modify system files in `C:\Windows\` or `C:\Program Files\`.

### 2. Network Isolation & Telemetry
* **Stripped Update & Catalog Endpoints**: All remote mod repository connections, external catalog fetching, and auto-update checks present in standard Windhawk have been disabled.
* **Zero Telemetry**: Contains no analytics, background phone-home metrics, or tracking mechanisms.
* **Symbol Lookup Scope**: Symbol enumeration checks local `%LOCALAPPDATA%\Sparrowhawk\AppData\Symbols\` first. In non-airgapped environments, standard Microsoft DbgHelp API calls query official Microsoft Symbol Servers (`msdl.microsoft.com`) only if local OS `.pdb` files are unpopulated.

### 3. Registry & System Impact
* **Single User Hive Scope**: Configuration settings are stored locally in plain-text `.ini` files (`sparrowhawk.ini`, `AppData\settings.ini`).
* **Autostart Isolation**: The optional autostart shortcut writes exclusively to the user's registry hive (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`), leaving HKEY_LOCAL_MACHINE (`HKLM`) completely untouched.

### 4. Restricted Injection Scope
* **Target Process Whitelisting**: Injection is strictly restricted to Windows user-shell interface components (`explorer.exe`, `ShellHost.exe`, `StartMenuExperienceHost.exe`, `ShellExperienceHost.exe`).
* **Critical Service Exclusion**: System service hosts (`svchost.exe`), Windows Defender / SmartScreen processes (`smartscreen.exe`), console host processes (`conhost.exe`, `powershell.exe`), and security software are explicitly bypassed and skipped at the engine level.

### 5. Build Integrity & Supply Chain Transparency
* **Reproducible CI/CD**: Binaries are compiled publicly on GitHub Actions using clean Microsoft-hosted `windows-2022` runners running MSBuild and Inno Setup.
* **SHA-256 Verification**: Every GitHub Release publishes a verified `SHA256SUMS.txt` hash file, allowing security teams to audit download integrity against the automated build log.

---

## Technical Specifications Summary

| Property | Value / Specification |
| :--- | :--- |
| **Executable Name** | `sparrowhawk.exe` |
| **Setup File** | `Sparrowhawk-Setup.exe` |
| **Default Install Directory** | `%LOCALAPPDATA%\Sparrowhawk\` |
| **Privileges Required** | Standard User (`AsInvoker`) |
| **UAC Elevation Required** | No |
| **Registry Scope** | `HKCU` Only (`Software\Microsoft\Windows\CurrentVersion\Run`) |
| **Upstream Lineage** | Windhawk Engine by Michael Maltsev (GPL-3.0) |
