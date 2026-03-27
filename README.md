**One Identity open source projects are supported through [One Identity GitHub issues](https://github.com/OneIdentity/ars-ps/issues) and the [One Identity Community](https://www.oneidentity.com/community/). This includes all scripts, plugins, SDKs, modules, code snippets or other solutions. For assistance with any One Identity GitHub project, please raise a new Issue on the [One Identity GitHub project](https://github.com/OneIdentity/ars-ps/issues) page. You may also visit the [One Identity Community](https://www.oneidentity.com/community/) to ask questions. Requests for assistance made through official One Identity Support will be referred back to GitHub and the One Identity Community forums where those requests can benefit all users.**

---

# Active Roles Management Shell for Active Directory

Active Roles Management Shell is an Active Directory-specific automation and scripting shell built on Microsoft Windows PowerShell. It provides a command-line interface for administering directory data either via Active Roles or by directly accessing Active Directory domain controllers.

With it, administrators can manage directory objects such as users and groups — creating accounts, modifying properties, and managing group membership.

---

## Repository Structure

```
.
├── Dockerfile               # Docker image definition
├── scripts/
│   ├── setup.bat            # Installs ActiveRoles silently inside the container
│   └── entrypoint.bat       # Launches the Active Roles Management Shell on container start
├── Samples/
│   ├── ADSI Provider/       # PowerShell and VBScript samples for the ADSI Provider
│   ├── ARServer Snap-in/    # C++ and C# snap-in extension samples (MMC and DS)
│   ├── RestrictGroupScope/  # Script to restrict group scope
│   └── WI/                  # Web Interface managed code sample
└── sdk-html/
    └── Docs/                # Full SDK HTML documentation (see Documentation section below)
```

---

## Docker Build

> **Note:** The Docker build requires downloading `ActiveRoles.exe` separately from the [One Identity website](https://www.oneidentity.com/products/active-roles/).

1. Download `ActiveRoles.exe`
2. Place it in the `scripts/` directory
3. Build the image:
   ```bat
   docker build -t ars-ps .
   ```
4. Run the container:
   ```bat
   docker run -it ars-ps
   ```

### Scripts

| File | Purpose |
|------|---------|
| `scripts/setup.bat` | Runs the `ActiveRoles.exe` silent installer inside the container, then removes the installer file |
| `scripts/entrypoint.bat` | Starts the Active Roles Management Shell (`ManagementShell.ps1`) when the container launches |

---

## Samples

The `Samples/` directory contains ready-to-use code examples organized by topic:

### ADSI Provider (`Samples/ADSI Provider/`)
PowerShell (`.ps1`) and VBScript (`.vbs`) samples covering:

| Category | Description |
|----------|-------------|
| `User/` | Create, copy, move, rename, enable/disable, reset password, deprovision users |
| `Group/` | Create, copy, move, rename, add/remove members |
| `Computer/` | Create, move, enable/disable, set description |
| `OU/` | Create, move, rename, search |
| `Access Template/` | Create, apply, link access templates |
| `Policy Object/` | Create, apply, import scripts into policy objects |
| `Managed Units/` | Create, list, add rules |
| `Mail-Enabled Users and Groups/` | Create/delete/move mailboxes, enable/disable mail |
| `Computer Resources/` | Manage printers, services, shares |
| `Virtual Attribute/` | Create and modify virtual attributes |
| `Approval/` | Get approval and operation status |
| `EDM Replication/` | Monitor replication partners, notify admins |
| `EDM Service/` | Get provider and service version info |

### ARServer Snap-in (`Samples/ARServer Snap-in/`)
C++ and C# extension samples for the Active Roles snap-in:

| Sample | Description |
|--------|-------------|
| `CustomPicker/` | C# custom picker UI component |
| `DS/Context Menu Extension/` | ATL C++ context menu extension for DS |
| `DS/Property Page Extension/` | ATL C++ property page extension for DS |
| `MMC/Property Page Extension/` | C++ property page extension for MMC snap-in |

### Other Samples
| Sample | Description |
|--------|-------------|
| `RestrictGroupScope/RestrictGroupScope.ps1` | Restrict the scope of Active Directory groups |
| `WI/managedcode.cs` | Web Interface managed code integration sample |

---

## Documentation

Full SDK documentation is available in `sdk-html/Docs/`, organized by module:

| Folder | Contents |
|--------|----------|
| `IntroducingEDMSoftwareDevelopmentKit/` | SDK overview, architecture, prerequisites, breaking/deprecated/discontinued features |
| `EnterpriseDirectoryManagerADSIProvider/` | Full ADSI Provider reference — objects, interfaces, methods, properties, search, approval |
| `EnterpriseDirectoryManagerScriptPolicy/` | Script policy development guide |
| `EnterpriseDirectoryManagerSnapin/` | Snap-in extension development guide |
| `EnterpriseDirectoryManagerWI/` | Web Interface customization guide |
| `ARSManagementShell/` | Management Shell reference and troubleshooting |
| `ARSAddons/` | Add-on configuration, install/uninstall scripts, system requirements |
| `Enumerations/` | Enumeration reference for SDK constants |
| `InstallingEDMResourceKit/` | Resource Kit installation guide |

Open any `.htm` file in a browser to navigate the docs locally.
