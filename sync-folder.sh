#!/usr/bin/env bash

# sync-folder.sh — rsync a single folder from remote phone to local directory

# ================== DEFAULTS ==================
REMOTE="u0_a275@192.168.1.196"
SSH_PORT="8022"
REMOTE_BASE="~/storage/shared"
FOLDER=""
TARGET=""

# ================== HELP ==================
usage() {
    cat <<EOF
Usage: ${0##*/} [options] <from> <to>

Rsync a single folder from a remote phone to a local directory.
The remote path is constructed as: $REMOTE_BASE/<from>/

Arguments:
  <from>         Remote folder to sync (relative to $REMOTE_BASE) (required)
  <to>           Local target directory (required)

Options:
  -r REMOTE      Remote user@host       (default: $REMOTE)
  -p PORT        SSH port               (default: $SSH_PORT)
  --help         Show this help
EOF
    exit 0
}

# ================== ARG PARSING ==================
POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -r) REMOTE="$2"; shift 2 ;;
        -p) SSH_PORT="$2"; shift 2 ;;
        --help) usage ;;
        -*) echo "Unknown option: $1" >&2; usage ;;
        *) POSITIONAL_ARGS+=("$1"); shift ;;
    esac
done

FOLDER="${POSITIONAL_ARGS[0]:-}"
TARGET="${POSITIONAL_ARGS[1]:-}"

# ================== VALIDATE ==================
[[ -z "$FOLDER" || -z "$TARGET" ]] && { echo "[!] <from> and <to> arguments are required" >&2; usage; }

# ================== SYNC ==================
mkdir -p "$TARGET"

RSYNC_ARGS=(-a --partial -e "ssh -p $SSH_PORT")

rsync_ver=$(rsync --version 2>/dev/null || true)
[[ "$rsync_ver" == *"version 3"* ]] && RSYNC_ARGS+=(--info=progress2) || RSYNC_ARGS+=(--progress)

echo "[*] $FOLDER → $TARGET"

if ! rsync "${RSYNC_ARGS[@]}" "$REMOTE:$REMOTE_BASE/$FOLDER/" "$TARGET/"; then
    echo "[!] rsync failed" >&2
    exit 1
fi

echo "[+] done"
exit 0
