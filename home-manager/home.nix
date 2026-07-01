{ config, pkgs, ... }:

let
  zsh-autocomplete-plugin = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
in
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
    spotify
  ] ++ [ pkgs.nerd-fonts.jetbrains-mono ];

  fonts.fontconfig.enable = true;

  home.file."config/ghostty/config".text = ''
    font-family = JetBrainsMono Nerd Font
    font-size = 12
    window-decoration = false
    window-padding-x = 12
    window-padding-y = 12
    background-opacity = 1.0
    background-blur-radius = 32
    cursor-style = block
    cursor-style-blink = true
    scrollback-limit = 3023
    mouse-hide-while-typing = true
    copy-on-select = false
    confirm-close-surface = false
    app-notifications = no-clipboard-copy,no-config-reload
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+t=new_tab
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+zero=reset_font_size
    unfocused-split-opacity = 0.7
    unfocused-split-fill = #44464f
    gtk-titlebar = false
    shell-integration = detect
    shell-integration-features = cursor,sudo,title,no-cursor
    keybind = shift+enter=text:\n
    gtk-single-instance = true
    theme = dankcolors
  '';

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
      format = "$all";
      spotify = {
        format = "via [$symbol $player]($style) ";
        symbol = "";
        style = "dimmed white";
        disabled = false;
      };
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
