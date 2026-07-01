{ config, pkgs, ... }:

{
  home.username = "jens";
  home.homeDirectory = "/home/jens";

  home.packages = with pkgs; [
    google-chrome
    ghostty
    bitwarden-desktop
    zotero
    vscode.fhs
    opencode
    zsh-autocomplete
  ];

  programs.git = {
    enable = true;
    userName = "Jens Birk Andersen";
    userEmail = "jens.birk.andersen@gmail.com";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "history"
        "history-substring-search"
      ];
    };

    initExtra = ''
      export EDITOR="vscode"
      source <(zsh-autocomplete.plugin.zsh)
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
