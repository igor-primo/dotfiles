#!/bin/bash

device_name="usb-BY_Tech_Gaming_Keyboard-event-kbd"

if [[ -e "/dev/input/by-id/${device_name}" ]]; then
  /usr/local/bin/kmonad-0.4.4 /home/igor/repos/kmonad/keymap/template/myconfig.kbd
fi
