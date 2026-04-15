#!/usr/bin/env bash

# backup-phone.sh — bulk sync specific folders from the phone

SCRIPT_DIR="${0%/*}"
[[ "$SCRIPT_DIR" == "$0" ]] && SCRIPT_DIR="."

FOLDERS=(
    "DCIM"
    "Pictures"
    "Documents"
    "Movies/Signal"
    "Vault"
)

usage() {
    echo "Usage: ${0##*/} [OPTIONS] [TARGET_BASE_DIR]"
    echo ""
    echo "Bulk sync specific folders from the phone to a local directory."
    echo ""
    echo "Options:"
    echo "  -h, --help       Show this help message and exit"
    echo ""
    echo "Arguments:"
    echo "  TARGET_BASE_DIR  Base directory for the backup (default: ~/phone-backup)"
    echo ""
    echo "Folders synced:"
    for f in "${FOLDERS[@]}"; do
        echo "  - $f"
    done
}

[[ "$1" == "-h" || "$1" == "--help" ]] && { usage; exit 0; }

# Default target directory
DEFAULT_BACKUP_DIR="${HOME}/phone-backup"

# Use the provided argument or fall back to the default
BACKUP_BASE="${1:-$DEFAULT_BACKUP_DIR}"

echo "[*] Starting bulk backup to: $BACKUP_BASE"

SUCCESS=0
TOTAL=${#FOLDERS[@]}

for folder in "${FOLDERS[@]}"; do
    echo ""
    echo "--- Syncing: $folder ---"

    target="$BACKUP_BASE/$folder"

    if "$SCRIPT_DIR/sync-folder.sh" "$folder" "$target"; then
        ((SUCCESS++))
    else
        echo "[!] Failed to sync: $folder" >&2
    fi
done

echo ""
echo "[*] Backup complete: $SUCCESS / $TOTAL folders synced to $BACKUP_BASE"
