<p align="center">
  <img src="assets/sparrowhawk.png" width="128" height="128" alt="Sparrowhawk Logo">
</p>

# Sparrowhawk

**Sparrowhawk** is a lightweight, offline-focused, non-elevated Windows taskbar customization engine based on the open-source [Windhawk](https://windhawk.net/) platform.

It is designed specifically for enterprise and workstation environments that require **no administrator/UAC elevation**, **no telemetry or app auto-updates**, and a **minimal system footprint**.

---

## 🌟 Key Features

- 🔒 **Standalone & Isolated**: All Windhawk server connections, remote mod catalog requests, telemetry, and auto-update endpoints are disabled. *(Note: If local symbol caches in `AppData\Symbols` are empty, the engine may attempt an HTTPS lookup to Microsoft's public Symbol Server `msdl.microsoft.com` for official OS `.pdb` files).*
- 👤 **Non-Elevated Execution (`AsInvoker`)**: Installs to `%LOCALAPPDATA%\Sparrowhawk` and runs strictly under standard user privileges without prompting for UAC administrator rights.
- ⏰ **Pre-baked Mods Included**:
  - **Vertical Taskbar**: Enables vertical taskbar positioning and layout enhancements.
  - **Taskbar Clock Customization**: Provides custom date/time formatting, performance metrics, and layout tweaks.
- 🚀 **Auto-Startup on Login**: Configures a standard user startup entry (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`) for seamless operation upon login.
- 📌 **Minimal System Tray Menu**: Features a lightweight Win32 system tray icon displaying active status and a clean exit command.
- ⚙️ **Automated CI/CD & SHA-256 Verification**: Built reproducibly using GitHub Actions with automatic SHA-256 checksum generation (`SHA256SUMS.txt`) for IT auditing and security verification.

---

## 🚀 Quick Start & Installation

1. Download **`Sparrowhawk-Setup.exe`** and **`SHA256SUMS.txt`** from the latest GitHub Release or Actions run.
2. (Optional) Verify the SHA-256 checksum in PowerShell:
   ```powershell
   Get-FileHash Sparrowhawk-Setup.exe -Algorithm SHA256
   ```
3. Double-click **`Sparrowhawk-Setup.exe`** to install. No administrator rights are required.
4. Sparrowhawk will launch immediately in the system tray and start automatically whenever you log in.

### Uninstallation
To remove Sparrowhawk, open Windows **Settings > Installed Apps** (or *Control Panel > Add or Remove Programs*) and select **Sparrowhawk > Uninstall**.

---

## 🛠️ How to Fork & Customize Settings

You can fork this repository, customize the mod settings to match your personal or organizational preferences, and let GitHub Actions compile a custom installer for you:

1. **Fork this repository** to your GitHub account.
2. **Edit Mod Settings**:
   - Edit [`dist/AppData/settings.ini`](dist/AppData/settings.ini) or default settings in `dist/AppData/Mods/` to adjust clock formatting or taskbar parameters.
3. **Trigger Build**:
   - Commit your changes or trigger the workflow manually under the **Actions** tab.
4. **Download Your Installer**:
   - GitHub Actions will build your custom **`Sparrowhawk-Setup.exe`** with your chosen settings pre-configured and output a verified `SHA256SUMS.txt`.

---

## 📜 Attribution & Licensing

Sparrowhawk is an open-source project released under the **GNU General Public License v3.0 (GPL-3.0)**.

- **Engine Lineage**: Based on **Windhawk** created by Michael Maltsev ([m417z](https://github.com/m417z) / [Ramen Software](https://ramensoftware.com/)).
- **Upstream Repositories**:
  - Windhawk Engine: [github.com/ramensoftware/windhawk](https://github.com/ramensoftware/windhawk)
  - Windhawk Mods: [github.com/ramensoftware/windhawk-mods](https://github.com/ramensoftware/windhawk-mods)
- **Mod Credits**:
  - *Taskbar Clock Customization* by m417z
  - *Vertical Taskbar* by m417z

For full details, please refer to the [`LICENSE`](LICENSE), [`ATTRIBUTION.md`](ATTRIBUTION.md), and [`SECURITY_AUDIT.md`](SECURITY_AUDIT.md) files.
