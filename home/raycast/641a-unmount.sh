#!/bin/zsh

# Raycast metadata
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unmount 641A
# @raycast.mode fullOutput
# @raycast.needsConfirmation true
#
# Optional parameters:
# @raycast.icon 🔐
# @raycast.packageName 641a-unmount
#
# Documentation:
# @raycast.description Unmounts the 641A volume.
# @raycast.author Joshua Suggs
# @raycast.authorURL https://suggs.io

source $HOME/.raycast/util.sh

MOUNT_POINT="$HOME/Documents/641A"

echo "Initializing..."
hacking_effect 3 0.05

# Check if mounted
if mount | grep -q "on $MOUNT_POINT "; then
  echo "Unmounting..."

  # Unmount the filesystem
  umount "$MOUNT_POINT"
  hacking_effect 5 0.05

  # Confirm success
  if mount | grep -q "on $MOUNT_POINT "; then
    echo "Failed to unmount 641A."
  else
    if command -v tag >/dev/null 2>&1; then
      tag -r Orange "$MOUNT_POINT"
    fi
    echo "641A unmounted successfully from $MOUNT_POINT."
  fi
else
  echo "641A is not mounted at $MOUNT_POINT."
fi