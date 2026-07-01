# dotfiles

NixOS + home-manager configuration.

## Structure

```
├── nixos/
│   ├── configuration.nix    # System-level config
│   └── hardware-configuration.nix  # Auto-generated hardware config
├── home-manager/
│   └── home.nix             # User-level config (packages, shell, etc.)
└── setup.sh                 # Bootstrap script for a fresh install
```

## What's configured

| Area | Details |
|------|---------|
| **WM** | niri compositor + dms-shell |
| **Shell** | zsh with oh-my-zsh, autocomplete, autosuggestions |
| **Prompt** | starship |
| **Tools** | zoxide, fzf, neovim |
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
4. Edit `nixos/configuration.nix` to adjust hostname, locale, etc.
5. Run the bootstrap script:
   ```bash
   cd ~/dotfiles && ./setup.sh
   ```

### What to customize per machine

- `networking.hostName` in `configuration.nix`
- `hardware-configuration.nix` (auto-generated per machine)
- `time.timeZone`
- `i18n` settings
- Framework imports (`<nixos-hardware/framework/...>`) — change or remove if not a Framework laptop

## Common commands

```bash
# Rebuild system (after changing config)
nixos-rebuild switch

# Update all channels
sudo nix-channel --update

# Apply home-manager changes without full rebuild
home-manager switch
```

## What's next / ideas

- **Automate dotfiles** — add more Nix-native configs (niri keybinds, ghostty settings, dms-shell theme)
- **Impermanence** — ephemeral root with persistent state
- **Stylix** — auto-theming from wallpaper
- **Auto-upgrades** — `system.autoUpgrade`
- **Secrets management** — sops-nix or agenix
- **Multi-machine** — split configs per host while sharing common modules
