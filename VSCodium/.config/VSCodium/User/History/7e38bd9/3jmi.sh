#!/bin/bash
dnf upgrade --refresh -y
dnf autoremove -y
dnf clean all
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
systemctl --failed --no-legend --no-pager \
  | awk '{print $1}' \
  | xargs -r sudo systemctl restart
