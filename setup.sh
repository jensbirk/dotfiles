#!/usr/bin/env bash
set -e

echo "🚀 Starting NixOS configuration setup..."

# 1. Define paths
REPO_DIR="$HOME/dotfiles/nixos"
ETC_DIR="/etc/nixos"

# 2. Add required nix channels
echo "📦 Adding nix channels..."
sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update

# 3. Safety check: make sure we are running this from the cloned repo
if [ ! -f "$REPO_DIR/configuration.nix" ]; then
    echo "❌ Error: Could not find configuration.nix in $REPO_DIR"
    echo "Make sure this repo is cloned into ~/dotfiles/nixos"
    exit 1
fi

# 4. Link the repo to /etc/nixos
if [ -d "$ETC_DIR" ] && [ ! -L "$ETC_DIR" ]; then
    echo "📦 Backing up fresh installation files to /etc/nixos.bak..."
    sudo mv "$ETC_DIR" "${ETC_DIR}.bak"
elif [ -L "$ETC_DIR" ]; then
    echo "🔗 Found an existing symlink at $ETC_DIR, removing it to re-link..."
    sudo rm "$ETC_DIR"
fi

echo "🔗 Linking $REPO_DIR to $ETC_DIR..."
sudo ln -s "$REPO_DIR" "$ETC_DIR"

# 5. Build the system
echo "🔨 Running NixOS rebuild..."
sudo nixos-rebuild switch

echo "✅ Setup complete! Your dotfiles are active."
