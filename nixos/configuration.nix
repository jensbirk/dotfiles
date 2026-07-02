{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jens = import ../home-manager/home.nix;
  };

programs.zsh.enable = true;
programs.niri.enable = true;
programs.dms-shell = {
  	enable = true;

  	systemd = {
    		enable = true;             # Systemd service for auto-start
    		restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  	};
  
  	# Core features
  	enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  	enableVPN = true;                  # VPN management widget
  	enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  	enableAudioWavelength = true;      # Audio visualizer (cava)
  	enableCalendarEvents = true;       # Calendar integration (khal)
  	enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
	};
	
  programs.neovim = {
	enable = true; 
  };
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jensnixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "niri";


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services = {
    login.fprintAuth = lib.mkForce true;
    sudo.fprintAuth = true;
  };
  security.pam.services.login.rules.auth.fprintd.args = lib.mkForce ["timeout=3"];
  security.pam.services.sudo.rules.auth.fprintd.args = lib.mkForce ["timeout=3"];

  # Tailscale
  services.tailscale.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."jens" = {
    isNormalUser = true;
    description = "Jens";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
    # Needed for home-manager to manage this user
    home = "/home/jens";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  # Allow unfree and specific insecure packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10" # this is for bitwarden
      "libsoup-2.74.3" # required by some packages
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  wget
  apple-cursor
  git
  hicolor-icon-theme
  gnome-icon-theme
  xwayland-satellite
  ];

xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
};
  

 system.stateVersion = "26.05"; # Did you read the comment?

  # Firware
  services.fwupd.enable = true;

  
  # --- Cursor
  programs.dconf.enable = true; # Ensures GTK settings can be read properly
  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24"; 
  };

  # Standardize the GTK configurations to match the fallback theme
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Adwaita
    gtk-cursor-theme-size=24
  '';
  
  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Adwaita
    gtk-cursor-theme-size=24
  '';
  # -----

}
