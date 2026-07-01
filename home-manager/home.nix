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
  ];

  programs.git = {
    enable = true;
    userName = "Jens Birk";
    userEmail = "jens@birk.one";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      export EDITOR="nvim"
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
