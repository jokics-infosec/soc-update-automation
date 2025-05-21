# secure-updater

<!-- Badges -->
<p align="left">
  <a href="https://github.com/YOUR_ORG/secure-updater/actions/workflows/shellcheck.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/YOUR_ORG/secure-updater/shellcheck.yml?label=ShellCheck&logo=gnu-bash" alt="ShellCheck Status">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/YOUR_ORG/secure-updater?color=blue" alt="License">
  </a>
</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A secure, production-ready Bash automation tool for safely updating Ubuntu and Pop!_OS systems. Designed for SOC analysts and IT-secured Linux workstations, it enforces strict security and logging standards.

## Features
- Distro validation (Ubuntu/Pop!_OS only)
- Secure, error-checked update flow
- Detailed logging to `/var/log/updates/`
- Modular, maintainable, and ShellCheck-clean
- Follows OWASP, NIST, and CERT Bash best practices

## Supported Operating Systems
- Ubuntu (all LTS and current releases)
- Pop!_OS (all supported releases)

## Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_ORG/secure-updater.git
   cd secure-updater
   ```
2. Review and copy the example environment file:
   ```bash
   cp .env.example .env
   # Edit .env as needed
   ```
3. Make the script executable:
   ```bash
   chmod +x scripts/secure_update.sh
   ```

## Usage
Run the script as root (with sudo):
```bash
sudo bash scripts/secure_update.sh
```

- Logs are stored in `/var/log/updates/secure_update_<timestamp>.log`.
- Only Ubuntu and Pop!_OS are supported. The script will exit on other distros.
- **Log files are root-readable only (default permissions: 750).**

## Example Output
```
[INFO] Starting secure update at 20240601_120000 for Ubuntu
[INFO] apt update completed successfully.
[INFO] Listed upgradable packages.
[INFO] apt upgrade completed successfully.
[INFO] apt autoremove completed successfully.
[INFO] apt clean completed successfully.
[INFO] Secure update completed at 2024-06-01 12:00:30
``` 