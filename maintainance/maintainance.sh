#!/usr/bin/env bash

until nmcli -t -f TYPE,STATE device status | grep -q "^wifi:connected$"; do
  sleep 10
done

rm -rf /var/cache/dnf/*
rm -rf /var/cache/libdnf5/*
dnf upgrade --refresh -y
dnf autoremove -y
dnf clean all
dnf clean metadata
flatpak update -y
dnf distro-sync -y
fwupdmgr refresh
fwupdmgr update
journalctl --rotate
journalctl --vacuum-size=100M
fstrim -v /
fstrim -v /home
rm -rf /home/*/.cache/*
rm -rf /tmp/*
rm -rf /var/tmp/*