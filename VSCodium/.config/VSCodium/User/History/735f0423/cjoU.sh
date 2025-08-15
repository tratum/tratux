#!/bin/bash

## Updating the Script
sudo dnf upgrade --refresh -y

## Enabling Some Copr Repositories

## Installing Packages
sudo dnf install zsh git fastfetch flatpak htop btop nvtop alacritty waybar rofi-wayland hyprlock hypridle -y wofi pamixer blueman grim slurp wl-clipboard jq dunst viewnior libnotify sddm qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia

# Manually Install Brave
curl -fsS https://dl.brave.com/install.sh | sh

# Manually install cliphist
json=$(curl --silent "https://api.github.com/repos/sentriz/cliphist/releases/latest")
asset_url=$(echo "$json" | jq -r '.assets[] | select(.name | test("linux-amd64")) | .browser_download_url')
if [ -z "$asset_url" ]; then
  echo "Error: No linux-amd64 asset found."
  exit 1
fi
curl -L -o cliphist "$asset_url"
chmod +x cliphist
sudo mv cliphist /usr/local/bin
cliphist wipe

# Manually install wallust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install wallust

## Configuring Packages
mkdir -p ~/.config/sway/
cp /etc/sway/config ~/.config/sway/config
mkdir -p ~/.config/waybar
cp /etc/xdg/waybar/config ~/.config/waybar/config
mkdir -p ~/.config/hypr
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi
mkdir -p ~/.config/wofi
mkdir -p ~/.config/alacritty

## Configuring SDDM Theme
sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
sudo sed -i 's|^ConfigFile=.*|ConfigFile=Themes/black_hole.conf|' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

## GTK Themes and Cursor Themes

# Setting Up Cursor Theme
latest_release_json=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest)
download_url=$(echo "$latest_release_json" | jq -r '.assets[] | select(.name=="Bibata-Modern-Ice.tar.xz") | .browser_download_url')
if [ -z "$download_url" ]; then
    echo "Asset not found!"
    exit 1
fi
curl -L -o Bibata-Modern-Ice.tar.xz "$download_url"
tar -xvf Bibata-Modern-Ice.tar.xz
mv Bibata-* ~/.local/share/icons/
sudo mv Bibata-* /usr/share/icons/

## Setting Up Fonts Used
font1="Afacad_Flux.zip"
f1Url="https://fonts.google.com/download?family=Afacad+Flux"
curl -L -o "${font1}" "${f1Url}"
if [ ! -f "${font1}" ]; then
    echo "Download failed! Exiting."
    exit 1
fi
unzip -o "${font1}" -d Afacad_Flux
mkdir -p ~/.local/share/fonts
find Afacad_Flux -name '*.ttf' -exec cp {} ~/.local/share/fonts/ \;
font2="JetBrainsMono.zip"
f2Url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
curl -L -o "${font2}" "${f2Url}"
if [ ! -f "${font2}" ]; then
    echo "Download failed! Exiting."
    exit 1
fi
unzip -o "${font2}" -d JetBrains_Mono
mkdir -p ~/.local/share/fonts
find JetBrains_Mono -name '*.ttf' -exec cp {} ~/.local/share/fonts/ \;
fc-cache -fv

