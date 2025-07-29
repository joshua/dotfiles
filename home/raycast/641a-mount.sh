#!/bin/zsh

# Raycast metadata
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mount 641A
# @raycast.mode fullOutput
# @raycast.needsConfirmation true
#
# Optional parameters:
# @raycast.icon 🔓
# @raycast.packageName 641a-mount
# @raycast.argument1 { "type": "password", "placeholder": "****" }mo
#
# Documentation:
# @raycast.description Mounts the 641A volume.
# @raycast.author Joshua Suggs
# @raycast.authorURL https://suggs.io

source $HOME/.raycast/util.sh

# Paths
ENCRYPTED_DIR="$HOME/Documents/03-resources/641A"
MOUNT_POINT="$HOME/Documents/641A"

OP_ITEM_REF="op://Private/641A/password"

# Check if already mounted
if mount | grep -q "on $MOUNT_POINT "; then
  echo "641A is already mounted at $MOUNT_POINT."
  exit 0
fi

echo "Initializing..."
hacking_effect 5 0.05

# Retrieve password from 1Password
EXTPASS_CMD="op read $OP_ITEM_REF"

# Simulate authentication
echo "Authenticating..."
hacking_effect 2 0.05

# Mount the filesystem
gocryptfs -extpass "$EXTPASS_CMD" "$ENCRYPTED_DIR" "$MOUNT_POINT" #>/dev/null 2>&1

# Continue the effect during mounting
hacking_effect 10 0.05

# Confirm success
if mount | grep -q "on $MOUNT_POINT "; then
  if command -v tag >/dev/null 2>&1; then
    tag -a Orange "$MOUNT_POINT"
  fi
  echo "641A mounted successfully at $MOUNT_POINT."
  open $MOUNT_POINT
else
  echo "Failed to mount 641A."
fi