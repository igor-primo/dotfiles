#!/bin/bash

device_name="usb-BY_Tech_Gaming_Keyboard-event-kbd"

if [[ -e "/dev/input/by-id/${device_name}" ]]; then
  /home/igor/.nix-profile/bin/kmonad /home/igor/.config/home-manager/dotfiles/kmonad.kbd
fi
