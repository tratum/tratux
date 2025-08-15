#!/bin/bash
sudo dnf upgrade --refresh -y
sudo dnf autoremove -y
sudo dnf clean all
flatpak update -y
sudo dnf distro-sync -y
fwupdmgr refresh
fwupdmgr update
journalctl --rotate
journalctl --vacuum-size=100M
fstrim -v /
rm -rf /home/*/.cache/*
rm -rf /tmp/*
rm -rf /var/tmp/*
systemctl --failed