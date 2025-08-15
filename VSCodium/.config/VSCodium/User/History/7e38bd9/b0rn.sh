#!/bin/bash
sudo dnf upgrade --refresh -y
sudo dnf autoremove -y
sudo dnf clean all
flatpak update -y
sudo dnf distro-sync -y