#!/bin/bash
# bash script to manage bitcoin wallets using the bitcoin-cli 
set -euo pipefail

# Function to log a message
# Usage: log <message>
# to log to system log uncomment the logger command
log() {
    # logger "$*"
    echo "$*"
}

# Function to run bitcoin-cli with common options
# Usage: bitcoin_cli <command> [<arguments>...]
bitcoin_cli() {
    bitcoin-cli -rpccookiefile=$BTC_COOKIE_FILE -rpcconnect=$BTC_NODE_IP -rpcport=$BTC_NODE_RPC_PORT "$@" || {
        log "ERROR: Failed to run bitcoin-cli command -check your server configuration: $*"
        exit 1
    }
}
# This function lists wallets - using the list wallets command
# Arguments: 
#   None - however it uses the NOMAD_HOST_IP_rpc and NOMAD_HOST_PORT_rpc environment variables which must be set
# Returns:
#   A list of wallets in the form of a json array of strings or an empty array
get_wallets() {
    # returns in stdout ['wallet-name'] or an empty array
    wallets=$(bitcoin_cli listwallets)
    echo "$wallets"
}

# This function lists information about a loaded wallet
# Arguments:
#   wallet_name - the name of the wallet to get information about
# Returns:
#   A json object with information about the wallet - for unlocking the most relavant key is the "unlocked_until" key   
get_wallet_info() {
    local wallet_name=$1
    bitcoin_cli  -rpcwallet="$wallet_name" getwalletinfo
}

# This function restores and loads a wallet - note that the created wallet is not unlocked
# Arguments:
#   wallet_name - the name of the wallet to restore and load
#   wallet_file - the absolute path and file to restore the wallet from
# Returns:
#   None or an error message if a wallet is already loaded
restore_wallet() {
    local wallet_name=$1
    local wallet_file=$2
    # returns in stdout nothing or an error message
   bitcoin_cli restorewallet $wallet_name $wallet_file true
}

# This function unlocks the wallet that is loaded for the specified time
# Arguments:
#   passphrase - the passphrase to unlock the wallet
#   timeout - the time in seconds to unlock the wallet for
# Returns:
#   None or an error message if the wallet is not loaded
unlock_wallet() {
    local passphrase=$1
    local timeout=$2
    # returns in stdout nothing or an error message
    bitcoin_cli walletpassphrase $passphrase $timeout
}

sleep 10 # wait for the bitcoin node to start
# Check if necessary environment variables are set
: "${BTC_COOKIE_FILE:?Need to set BTC_COOKIE_FILE}"
: "${BTC_NODE_IP:?Need to set BTC_NODE_IP}"
: "${BTC_NODE_RPC_PORT:?Need to set BTC_NODE_RPC_PORT}"
: "${BTC_WALLET_NAME:?Need to set BTC_WALLET_NAME}"
: "${SECRETS_PATH:?Need to set SECRETS_PATH}"

# Variables required for the script
wallet_timeout=15552000 # 6 months in seconds
wallet_name="${BTC_WALLET_NAME}"
# this loads a wallet from designated location on the server machine
wallet_file_path="/home/bitcoin/wallet.dat"
{{- with secret (printf "signing_keys/%s/btc-signer-wallet0" (env "SECRETS_PATH")) }}
passphrase="{{ .Data.data.wallet_passphrase }}"
{{- end }}


log "Checking if wallets are loaded"
wallets=$(get_wallets)

if [ "$(echo "$wallets" | tr -d '[:space:]')" == "[]" ]; then
    # the restored wallet name
    log "No wallets loaded will load and restore wallet [$wallet_name] from the server at $wallet_file_path"
    restore_wallet $wallet_name $wallet_file_path
    if [ $? -ne 0 ]; then
        log "ERROR: Failed to restore wallet [$wallet_name] from $wallet_file_path"
        exit 1
    fi
    log "Wallet [$wallet_name] restored and loaded"
    unlock_wallet "$passphrase" $wallet_timeout
    if [ $? -ne 0 ]; then
        log "ERROR: Failed to unlock wallet [$wallet_name]"
        exit 1
    fi
else
    first_wallet=$(echo "$wallets" | jq -r '.[0]')
    log "Wallet loaded: $first_wallet - will unlock the wallet so it is available for $wallet_timeout seconds"
    unlock_wallet "$passphrase" $wallet_timeout
fi
# confirm from the wallet info that the wallet is unlocked and the time remaining in days
wallet_info=$(get_wallet_info $wallet_name)
wallet_unlocked_until=$(echo $wallet_info | jq -r '.unlocked_until')
log "Wallet [$wallet_name] unlocked until $(date -d @$wallet_unlocked_until)"

log "Successfully finished wallet management tasks..."
exit 0
