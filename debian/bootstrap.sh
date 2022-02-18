#!/bin/bash
# CloudInit custom bootstrap.sh script
# Update this script to update the cloudinit execution for new AWS isntances.
# It will not trigger a rebuild of existing instances.

set -euo pipefail

log() {
  logger "$*"
  echo "$*"
}

__HOSTNAME="$(hostname)"

log "Starting remote bootstrap script"

log "Searching for per-server bootstrap script"
wget "https://raw.githubusercontent.com/cephalopodequipment/config/main/debian/${__HOSTNAME}.sh" || log "No custom file for this server"
if [ -f "${__HOSTNAME}.sh" ]; then
  log "Custom bootstrap file found."
  chmod 755 "${__HOSTNAME}.sh"
  source "${__HOSTNAME}.sh"
fi

log "Finished remote bootstrap script"
