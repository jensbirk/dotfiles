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
    vscode.fhs
    opencode
    zsh-autocomplete
    spotify
    discord
    localsend
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

  home.stateVersion = "26.05";
}
