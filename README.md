# Phone Backup Scripts

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/language-Bash-4EAA25.svg)

A high-performance, Pure Bash toolset designed to automate the backup of specific directories from an Android device (via Termux/SSH) to a local workstation. This project prioritizes execution efficiency and minimal process overhead using optimized shell scripting patterns.

## Features

- **Performance-Optimized**: Optimized execution flow with minimal subshells and forks.
- **Bulk Sync**: Automated backup of multiple predefined directories in a single command.
- **Standalone Utility**: Includes a versatile sync tool for individual folder transfers.
- **Dependency Validation**: Built-in checks to ensure required binaries are available.
- **Automated Workflow**: Makefile-driven interface for easy execution and management.

## Tech Stack

- **Scripting**: Pure Bash (High-Performance Architecture)
- **Sync Engine**: Rsync
- **Transport**: SSH
- **Automation**: GNU Make

## Project Structure

- `phonesync`: The primary entry point for bulk backups.
- `rcp`: A standalone utility for individual folder synchronization.
- `Makefile`: Command-line interface for running and checking the project.
- `LICENSE`: MIT License documentation.

## Installation

1. **Prerequisites**: Ensure `rsync` and `ssh` are installed on both the local machine and the remote Android device (e.g., via Termux).
2. **Clone the repository**:
   ```bash
   git clone https://github.com/unamatasanatarai/termux-phone-rsync
   cd backup-phone
   ```
3. **Verify Dependencies**:
   ```bash
   make check
   ```

## Usage

### Automated Backup
To execute the full backup suite as defined in the configuration:
```bash
make
```

### Manual Individual Sync
Use the `rcp` utility to sync specific directories:
```bash
./rcp [-p PORT] <from> <to>
```
*Example:*
```bash
./rcp -p 8022 u0_a275@192.168.1.196:~/photos ~/backups/photos
```

## Configuration

### Sync Targets
Backup locations are managed within the `_folders` associative array in `phonesync`. To modify sync targets, update the keys (remote paths) and values (local paths) in that file.

### Connection Settings
The default SSH port and remote credentials can be adjusted in both `phonesync` and `rcp` via the `_ssh_port` variable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
