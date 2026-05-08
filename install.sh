#!/usr/bin/env bash

# Pure Bash installer for bash-utils
# Target: ~/.local/bin

__target="${HOME}/.local/bin"

# Resolve script directory without subshells or dirname
__dir="${BASH_SOURCE[0]%/*}"
[[ "$__dir" == "${BASH_SOURCE[0]}" ]] && __dir="."

# Ensure target directory exists
if [[ ! -d "$__target" ]]; then
    mkdir -p "$__target"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to create %s\n" "$__target" >&2
        exit 1
    fi
fi

# Iterate files using globbing
for __file in "${__dir}"/*; do
    # Skip directories
    [[ -d "$__file" ]] && continue

    __name="${__file##*/}"

    # Only install specific scripts
    case "$__name" in
    "rcp" | "phonesync")
        # Proceed to install
        ;;
    *)
        # Skip all other files (Makefile, LICENSE, install.sh, etc.)
        continue
        ;;
    esac

    # Copy and set permissions
    cp "$__file" "$__target/"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to copy %s\n" "$__name" >&2
        exit 1
    fi

    chmod +x "$__target/$__name"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to set permissions on %s\n" "$__name" >&2
        exit 1
    fi

    printf "Installed: %s\n" "$__name"
done

# PATH check using glob match
if [[ ":$PATH:" != *":$__target:"* ]]; then
    printf "\nWARNING: %s is not in PATH\n" "$__target" >&2
    printf "Add to your shell config:\n" >&2
    printf "export PATH=\"\$HOME/.local/bin:\$PATH\"\n" >&2
    exit 2
fi

printf "\nInstallation complete\n"
