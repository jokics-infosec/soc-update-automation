#!/bin/bash
# secure_update.sh - Secure OS Updater for Ubuntu/Pop!_OS
#
# WARNING: Run this script with sudo/root privileges.
#
# Author: SOC Automation Team
# Version: 1.0.0
# License: MIT
#
# Description:
#   Safely updates Ubuntu/Pop!_OS systems, logs all actions, and enforces security best practices.
#   Fails on unsupported distros. Logs are stored in /var/log/updates/secure_update_<timestamp>.log
#
# Security:
#   - Follows OWASP, NIST SP 800-53, and CERT Bash scripting standards
#   - No hardcoded secrets; all input/output is validated or controlled
#   - ShellCheck clean, POSIX-compliant where possible
#
set -euo pipefail

# Trap unexpected errors and print a helpful message
trap 'echo "[ERROR] An unexpected error occurred. Exiting." >&2; exit 1' ERR

# Validate running as root
if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] This script must be run as root (sudo)." >&2
  exit 1
fi

# Validate supported distro
SUPPORTED_DISTROS=("Ubuntu" "Pop!_OS")
DISTRO="$(. /etc/os-release && echo "$NAME")"
IS_SUPPORTED=false
for d in "${SUPPORTED_DISTROS[@]}"; do
  if [[ "$DISTRO" == "$d" ]]; then
    IS_SUPPORTED=true
    break
  fi
done
if [[ "$IS_SUPPORTED" != true ]]; then
  echo "[ERROR] Unsupported Linux distribution: $DISTRO" >&2
  echo "Supported: ${SUPPORTED_DISTROS[*]}" >&2
  exit 2
fi

# Prepare logging
LOG_DIR="/var/log/updates"
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
LOG_FILE="$LOG_DIR/secure_update_${TIMESTAMP}.log"

if [[ ! -d "$LOG_DIR" ]]; then
  mkdir -p "$LOG_DIR"
  chmod 750 "$LOG_DIR"
fi

echo "[INFO] Starting secure update at $TIMESTAMP for $DISTRO" | tee "$LOG_FILE"

# Update package lists
if apt update 2>&1 | tee -a "$LOG_FILE"; then
  echo "[INFO] apt update completed successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] apt update failed." | tee -a "$LOG_FILE"
  exit 3
fi

# List upgradable packages
if apt list --upgradable 2>&1 | tee -a "$LOG_FILE"; then
  echo "[INFO] Listed upgradable packages." | tee -a "$LOG_FILE"
else
  echo "[ERROR] Failed to list upgradable packages." | tee -a "$LOG_FILE"
  exit 4
fi

# Upgrade packages
if apt upgrade -y 2>&1 | tee -a "$LOG_FILE"; then
  echo "[INFO] apt upgrade completed successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] apt upgrade failed." | tee -a "$LOG_FILE"
  exit 5
fi

# Autoremove unused packages
if apt autoremove -y 2>&1 | tee -a "$LOG_FILE"; then
  echo "[INFO] apt autoremove completed successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] apt autoremove failed." | tee -a "$LOG_FILE"
  exit 6
fi

# Clean up package cache
if apt clean 2>&1 | tee -a "$LOG_FILE"; then
  echo "[INFO] apt clean completed successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] apt clean failed." | tee -a "$LOG_FILE"
  exit 7
fi

echo "[INFO] Secure update completed at $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
exit 0 