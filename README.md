# dotfiles

NixOS + home-manager configuration using flakes.

## Structure

```
├── flake.nix                  # Flake entry point
├── .envrc                     # Direnv activation (use flake)
├── nixos/
│   ├── configuration.nix      # System-level config
│   └── hardware-configuration.nix  # Auto-generated hardware config
├── home-manager/
│   └── home.nix               # User-level config (packages, shell, etc.)
└── setup.sh                   # Bootstrap script for a fresh install
```

## What's configured

| Area | Details |
|------|---------|
| **Flakes** | NixOS + home-manager + nixos-hardware as flake inputs |
| **WM** | niri compositor + dms-shell |
| **Shell** | zsh with oh-my-zsh, autocomplete, autosuggestions |
| **Prompt** | starship |
| **Tools** | zoxide, fzf, neovim, direnv |
| **Packages** | ghostty, vscode, firefox, bitwarden, zotero, google-chrome, opencode |
| **Fonts** | JetBrainsMono Nerd Font |
| **Services** | tailscale, printing, pipewire, fwupd |

## Setting up a new machine

1. Install NixOS normally (use the default installer)
2. Clone this repo:
   ```bash
   nix-shell -p git --run "git clone https://github.com/jensbirk/dotfiles ~/dotfiles"
   ```
3. Generate hardware config for the new machine:
   ```bash
   sudo nixos-generate-config --show-hardware > ~/dotfiles/nixos/hardware-configuration.nix
   ```
4. Edit `nixos/configuration.nix` to adjust hostname, locale, user, etc.
5. Run the bootstrap script:
   ```bash
   cd ~/dotfiles && ./setup.sh
   ```

### What to customize per machine

- `networking.hostName` in `configuration.nix`
- `hardware-configuration.nix` (auto-generated per machine)
- `time.timeZone` and `i18n` settings
- `nixos-hardware` module in `flake.nix` — change if not a Framework 13" AMD AI 300

## Common commands

```bash
# Rebuild system using the flake
nixos-rebuild switch --flake .#jens_nixos

# Update flake inputs (lockfile)
nix flake update

# Rebuild with updates from upstream
nixos-rebuild switch --flake .#jens_nixos --update-input nixpkgs

# Apply home-manager changes without full rebuild
home-manager switch --flake .#jens_nixos

# Enter dev shell (if .envrc is trusted)
direnv allow
```

## What's next / ideas

- **Impermanence** — ephemeral root with persistent state
- **Stylix** — auto-theming from wallpaper
- **Auto-upgrades** — `system.autoUpgrade`
- **Secrets management** — sops-nix or agenix
- **Multi-machine** — split configs per host while sharing common modules
