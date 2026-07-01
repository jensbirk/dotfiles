#!/usr/bin/env bash
set -e

echo "🚀 Starting NixOS configuration setup..."

REPO_DIR="$HOME/dotfiles"
FLAKE="$REPO_DIR#jens_nixos"

# Safety check
if [ ! -f "$REPO_DIR/flake.nix" ]; then
    echo "❌ Error: Could not find flake.nix in $REPO_DIR"
    echo "Make sure this repo is cloned into ~/dotfiles"
    exit 1
fi

# Build the system using the flake.
# NIX_CONFIG enables flakes for this command on a fresh install.
echo "🔨 Building system with flake..."
NIX_CONFIG="experimental-features = nix-command flakes" \
  sudo nixos-rebuild switch --flake "$FLAKE"

echo "✅ Setup complete! Your dotfiles are active."
echo ""
echo "Reboot or start a new shell to enjoy your new system."
