#!/bin/bash

wifi_status=$(nmcli radio wifi)

if [[ "$wifi_status" == "enabled" ]]; then
  nmcli radio wifi off
else
  nmcli radio wifi on
  sleep 1
  nmcli dev wifi rescan
fi
