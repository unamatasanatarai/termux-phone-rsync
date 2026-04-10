# Phone Backup Scripts

A set of simple shell scripts to bulk-sync specific folders from an Android phone (running Termux/SSH) to a local machine using `rsync`.

## Features

- **Modular Design**: A main script for bulk backups and a helper script for individual folder syncs.
- **Progress Tracking**: Uses `rsync` progress reporting.
- **Flexible Targets**: Supports custom backup directories or defaults to timestamped folders.
- **Help Documentation**: Built-in `--help` flags for all scripts.

## Installation & Requirements

1. **Rsync**: Ensure `rsync` is installed on both your local machine and the phone.
2. **SSH**: The phone should have an SSH server running (e.g., via Termux).
3. **SSH Keys**: It is highly recommended to set up SSH key-based authentication so you don't have to enter a password for every folder.

## Scripts

### 1. `backup-phone.sh`

The primary script for backing up multiple folders at once.

**Usage:**
```bash
./backup-phone.sh [TARGET_BASE_DIR]
```

- **TARGET_BASE_DIR**: (Optional) The directory where backups will be stored. Defaults to `~/phone-backup/YYYY-MM-DD-HH`.
- **Options**: Use `--help` to see synced folders and usage details.

**Example:**
```bash
./backup-phone.sh ~/backups/my-phone
```

### 2. `sync-folder.sh`

A helper script used by `backup-phone.sh` to sync a single directory. It can also be used independently.

**Usage:**
```bash
./sync-folder.sh [options] <from> <to>
```

- **Arguments**:
    - `<from>`: Remote folder to sync (relative to the remote base path).
    - `<to>`: Local target directory.
- **Options**:
    - `-r REMOTE`: Remote `user@host` (default: `u0_a275@192.168.1.196`).
    - `-p PORT`: SSH port (default: `8022`).

## Configuration

### Sync Folders
To change which folders are backed up, edit the `FOLDERS` array in `backup-phone.sh`:

```bash
FOLDERS=(
    "DCIM"
    "Pictures"
    "Documents"
    "Movies/Signal"
    "Vault"
)
```

### Remote Connection
To change the default remote host or path, update the variables in `sync-folder.sh`:

```bash
REMOTE="u0_a275@192.168.1.196"
SSH_PORT="8022"
REMOTE_BASE="~/storage/shared"
```

## License

MIT
