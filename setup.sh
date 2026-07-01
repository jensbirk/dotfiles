#!/usr/bin/env bash
set -e

echo "🚀 Starting NixOS configuration setup..."

REPO_DIR="$HOME/dotfiles"

# Safety check
if [ ! -f "$REPO_DIR/flake.nix" ]; then
    echo "❌ Error: Could not find flake.nix in $REPO_DIR"
    echo "Make sure this repo is cloned into ~/dotfiles"
    exit 1
fi

# Link repo root to /etc/nixos so `nixos-rebuild switch` works without --flake
echo "🔗 Linking $REPO_DIR to /etc/nixos..."
sudo rm -rf /etc/nixos
sudo ln -s "$REPO_DIR" /etc/nixos

# Build the system.
# NIX_CONFIG enables flakes for this command on a fresh install.
echo "🔨 Building system..."
NIX_CONFIG="experimental-features = nix-command flakes" \
  sudo nixos-rebuild switch

echo "✅ Setup complete! Your dotfiles are active."
echo ""
echo "Reboot or start a new shell to enjoy your new system."
