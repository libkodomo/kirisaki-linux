#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Core Kirisaki session and desktop utilities.
dnf5 install -y \
	brightnessctl \
	flatpak \
	fastfetch \
	foot \
	git \
	grim \
	mako \
	NetworkManager \
	pavucontrol \
	pipewire \
	pipewire-pulseaudio \
	playerctl \
	polkit \
	sddm \
	slurp \
	sway \
	swayidle \
	swaylock \
	waybar \
	wl-clipboard \
	wofi \
	wireplumber \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-wlr \
	tmux

flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --system --noninteractive flathub \
	org.mozilla.firefox \
	org.videolan.VLC \
	org.libreoffice.LibreOffice \
	org.gnome.Loupe \
	org.gnome.Nautilus

mkdir -p /var/home/linuxbrew/.linuxbrew
git clone --depth=1 https://github.com/Homebrew/brew /var/home/linuxbrew/.linuxbrew/Homebrew
mkdir -p /var/home/linuxbrew/.linuxbrew/bin
ln -sf ../Homebrew/bin/brew /var/home/linuxbrew/.linuxbrew/bin/brew
chmod -R a+rwX /var/home/linuxbrew/.linuxbrew

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable NetworkManager.service
systemctl enable sddm.service
