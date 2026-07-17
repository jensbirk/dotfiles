{ config, pkgs, ... }:

let
  zsh-autocomplete-plugin = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
in
{
  home.username = "jens";
  home.homeDirectory = "/home/jens";

  home.packages = with pkgs; [
    teleport
    google-chrome
    ghostty
    bitwarden-desktop
    zotero
    obsidian
    vscode.fhs
    opencode
    zsh-autocomplete
    spotify
    discord
    localsend
    libvirt
  ] ++ [ pkgs.nerd-fonts.jetbrains-mono ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Jens Birk Andersen";
      user.email = "jens.birk.andersen@gmail.com";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      directory = {
        truncation_length = 3;
        style = "bold cyan";
      };
      git_branch = {
        style = "bold bright-cyan";
        format = "on [$symbol$branch]($style) ";
      };
      git_status = {
        style = "bold yellow";
        conflicted = "🏵 ";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕\${count}";
        stashed = "📦 ";
        modified = "!";
        staged = "+\${count}";
        renamed = "»";
        deleted = "✕";
      };
      nodejs = {
        style = "bold green";
        format = "via [$symbol($version )]($style)";
      };
      rust = {
        style = "bold red";
        format = "via [$symbol($version )]($style)";
      };
      python = {
        style = "bold yellow";
        format = "via [$symbol($version )]($style)";
      };
      nix_shell = {
        style = "bold blue";
        symbol = "❄️ ";
        format = "[$symbol$state( \($name\))]($style) ";
      };
      cmd_duration = {
        style = "bold yellow";
        format = "⏱️ [$duration]($style) ";
      };
      line_break.disabled = false;
      format = ''
        [╭─](bold bright-black)$all
        [╰─](bold bright-black)$character'';
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins = [
        "git"
        "history"
        "history-substring-search"
      ];
    };

    initContent = ''
      export EDITOR="vscode"
      source ${zsh-autocomplete-plugin}
    '';
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      size = 24;
    };
  };

  xdg.configFile."niri/config.kdl".text = ''
    config-notification {
        disable-failed
    }

    gestures {
        hot-corners {
            off
        }
    }

    input {
        keyboard {
            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    layout {
        background-color "transparent"
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }
        border {
            off
            width 4
            active-color   "#707070"
            inactive-color "#d0d0d0"
            urgent-color   "#cc4444"
        }
        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
        struts {
        }
    }

    layer-rule {
        match namespace="^quickshell$"
        place-within-backdrop true
    }

    overview {
        workspace-shadow {
            off
        }
    }

    environment {
      XDG_CURRENT_DESKTOP "niri"
      XCURSOR_SIZE "24"
      XCURSOR_THEME "Adwaita"
    }

    hotkey-overlay {
        skip-at-startup
    }

    prefer-no-csd
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    animations {
        workspace-switch {
            spring damping-ratio=0.80 stiffness=523 epsilon=0.0001
        }
        window-open {
            duration-ms 150
            curve "ease-out-expo"
        }
        window-close {
            duration-ms 150
            curve "ease-out-quad"
        }
        horizontal-view-movement {
            spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
        }
        window-movement {
            spring damping-ratio=0.75 stiffness=323 epsilon=0.0001
        }
        window-resize {
            spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
        }
        config-notification-open-close {
            spring damping-ratio=0.65 stiffness=923 epsilon=0.001
        }
        screenshot-ui-open {
            duration-ms 200
            curve "ease-out-quad"
        }
        overview-open-close {
            spring damping-ratio=0.85 stiffness=800 epsilon=0.0001
        }
    }

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id=r#"^org\.gnome\."#
        draw-border-with-background false
        geometry-corner-radius 12
        clip-to-geometry true
    }

    window-rule {
        match app-id=r#"^gnome-control-center$"#
        match app-id=r#"^pavucontrol$"#
        match app-id=r#"^nm-connection-editor$"#
        default-column-width { proportion 0.5; }
        open-floating false
    }

    window-rule {
        match app-id=r#"^org\.gnome\.Calculator$"#
        match app-id=r#"^gnome-calculator$"#
        match app-id=r#"^galculator$"#
        match app-id=r#"^blueman-manager$"#
        match app-id=r#"^org\.gnome\.Nautilus$"#
        match app-id=r#"^xdg-desktop-portal$"#
        open-floating true
    }

    window-rule {
        match app-id=r#"^steam$"# title=r#"^notificationtoasts_\d+_desktop$"#
        default-floating-position x=10 y=10 relative-to="bottom-right"
        open-focused false
    }

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        match app-id="Alacritty"
        match app-id="zen"
        match app-id="com.mitchellh.ghostty"
        match app-id="kitty"
        draw-border-with-background false
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        match app-id="zoom"
        open-floating true
    }

    window-rule {
        match app-id=r#"org.quickshell$"#
        match app-id=r#"com.danklinux.dms$"#
        open-floating true
    }

    debug {
        honor-xdg-activation-with-invalid-serial
    }

    recent-windows {
        binds {
            Alt+Tab         { next-window scope="output"; }
            Alt+Shift+Tab   { previous-window scope="output"; }
            Alt+grave       { next-window filter="app-id"; }
            Alt+Shift+grave { previous-window filter="app-id"; }
        }
    }

    cursor {
        xcursor-theme "Adwaita"
        xcursor-size 24
    }

    include "dms/colors.kdl"
    include "dms/layout.kdl"
    include "dms/alttab.kdl"
    include "dms/binds.kdl"
    include "dms/outputs.kdl"
    include "dms/cursor.kdl"
  '';

  home.stateVersion = "26.05";
}
