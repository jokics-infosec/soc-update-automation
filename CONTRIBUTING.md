# Contributing to secure-updater

## Folder Structure
- `scripts/` — All automation scripts
- `docs/` — Developer and security documentation
- `config/` — (Reserved for future config files)

## Bash Standards
- All scripts must pass ShellCheck with no errors
- Use POSIX-compliant syntax where possible
- Use `set -euo pipefail` at the top of every script
- No hardcoded secrets or credentials
- All input/output must be validated or controlled

## Commit Messages
- Use clear, descriptive messages (e.g., `fix: handle unsupported distro error`)
- Reference issues or PRs when relevant

## Secure Coding Review Checklist
- [ ] Script is ShellCheck clean
- [ ] Follows OWASP, NIST SP 800-53, and CERT Bash standards
- [ ] No hardcoded secrets
- [ ] All logs are access-controlled
- [ ] All error paths are handled
- [ ] Code is modular and well-commented

## Pull Request Expectations
- Describe what and why you changed
- Reference related issues
- Ensure all CI checks pass
- Request review from a security-focused team member 