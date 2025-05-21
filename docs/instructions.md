# Developer Instructions: secure-updater

## Security Assumptions
- Script is run with root privileges (sudo)
- System is Ubuntu or Pop!_OS (checked at runtime)
- No secrets or sensitive data are hardcoded
- All logs are written to `/var/log/updates/` with restricted permissions

## Supported Distributions
- Ubuntu (all LTS/current)
- Pop!_OS (all supported)

## Logging Logic
- Log directory: `/var/log/updates/` (created if missing)
- Log file: `secure_update_<timestamp>.log` (timestamp: `YYYYMMDD_HHMMSS`)
- All script output and errors are logged and echoed to the user
- Log files are root-readable only (default 750 perms)

## Timestamps
- Log filenames and entries use `date '+%Y%m%d_%H%M%S'` and `date '+%Y-%m-%d %H:%M:%S'`

## Extending/Modifying
- Add new distros by updating the `SUPPORTED_DISTROS` array and logic
- Add new features by following the modular, commented style
- Always validate input/output and follow ShellCheck/CERT/NIST/OWASP guidance
- Test changes in a VM or container before production use 