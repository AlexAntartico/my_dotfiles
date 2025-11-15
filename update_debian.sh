#!/usr/bin/bash
# update.sh
# Description: A script to update APT, snap and flatpak packages on a Debian-based system.
# ie, some linux mint implementations dont come with snap installed

set -e  # Exit on error
set -o pipefail

# --- Configuration ---
SCRIPT_BASE_NAME="$(basename "$0" .sh)"
TIMESTAMP=$(date '+%Y-%m-%d-%H-%M')
SCRIPT_NAME="${SCRIPT_BASE_NAME}-${TIMESTAMP}"
LOG_FILE="/var/log/$SCRIPT_NAME.log"

# --- Functions ---
# Functions only job is to format log messages and print them
# Main block's redirection will handle the output and appending to log file
log () {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [LOG] - $1"
}

# --- Pre-flight Checks ---
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use 'sudo'." >&2
    exit 1
fi

# ---- Main ---
# Redirecting 1 and 2 from entire block to log file AND to screen
{
    # Updating APT packages
    log "Starting system update..."
    apt update
    apt upgrade -y

    # clean up old packages
    echo
    log "Cleaning up old packages..."
    apt autoremove -y
    apt autoclean -y

    # Updating snap packages IF snap is available
    if command -v snap >/dev/null 2>&1; then
        echo
        log "Updating snap packages..."
        snap refresh
    else
        echo
        log "snap command not found. Skipping snap refresh."
    fi

    # Updating Flatpak packages IF flatpak is available
    if command -v flatpak >/dev/null 2>&1; then
        echo
        log "Updating Flatpak packages..."
        flatpak update -y
    else
        echo
        log "flatpak command not found. Skipping Flatpak update."
    fi

} 2>&1 | tee -a "$LOG_FILE"

log "System update completed successfully." | tee -a "$LOG_FILE"

# --- HooOOman msg ---
echo -e "\n--------------------------------------------------"
echo "✅ All tasks complete. Log file saved to: $LOG_FILE"
echo -e "--------------------------------------------------\n"

exit 0
