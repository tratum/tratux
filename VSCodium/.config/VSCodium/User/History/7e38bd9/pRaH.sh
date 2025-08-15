#!/bin/bash
sudo dnf upgrade --refresh -y
sudo dnf autoremove -y
sudo dnf clean all
flatpak update -y
sudo dnf distro-sync -y
fwupdmgr refresh
fwupdmgr update
sudo journalctl --rotate
sudo journalctl --vacuum-size=100M
sudo fstrim -v /
sudo fstrim -v /home
sudo rm -rf /home/*/.cache/*
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
systemctl --failed