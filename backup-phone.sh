#!/usr/bin/env bash

SCRIPT_DIR="${0%/*}"
[[ "$SCRIPT_DIR" == "$0" ]] && SCRIPT_DIR="."

declare -A FOLDERS=(
    ["u0_a275@192.168.1.196:~/storage/shared/DCIM/Camera"]="$HOME/phone-backup/photos"
    ["u0_a275@192.168.1.196:~/storage/shared/Pictures/Signal"]="$HOME/phone-backup/photos"
    ["u0_a275@192.168.1.196:~/storage/shared/Pictures/Snapseed"]="$HOME/phone-backup/photos/snapseed"
    ["u0_a275@192.168.1.196:~/storage/shared/Documents"]="$HOME/phone-backup/docs"
    ["u0_a275@192.168.1.196:~/storage/shared/Movies/Signal"]="$HOME/phone-backup/photos/signal"
    ["u0_a275@192.168.1.196:~/storage/shared/Vault"]="$HOME/phone-backup/Vault"
)

SUCCESS=0

for from in "${!FOLDERS[@]}"; do
    "$SCRIPT_DIR/rcp" "$from" "${FOLDERS[$from]}" && ((SUCCESS++))
done

echo ""
echo "[*] Backup complete: $SUCCESS / ${#FOLDERS[@]} folders synced"
