#!/bin/bash

state=$(rfkill list bluetooth | grep -i "Soft blocked" | awk '{print $3}')

if [ "$state" == "yes" ]; then
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi
