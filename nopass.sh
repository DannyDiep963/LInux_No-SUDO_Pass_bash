#!/bin/bash

if [ "" = grep '$USER ALL=(ALL) NOPASSWD:ALL' ]; then
  echo "Permissionless sudo is unabled. Activating mode..."
  sudo bash -c 'echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoer.d/99_sudo_include_file'
else
  echo "Permissionless sudo is enabled"
fi
