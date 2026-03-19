{ config, pkgs, inputs, ... }:

let
  # Helper function to symlink directories
  # Usage: linkConfig "niri" links ./dotfiles/niri to ~/.config/niri
  linkConfig = name: {
    ".config/${name}".source = ../dotfiles/${name};
  };
in
{
  # Install Packages
  home.packages = with pkgs; [
    # Development
    nodejs
    typescript
    typescript-language-server

    # Dependencies for the Bar (Fonts & Tools)
    material-symbols # Icon font
    waybar
    wireplumber      # Audio
    networkmanager   # Network
    upower           # Battery
    gtk3             # GTK Llibs
    glib

    # GUI Apps
    firefox
    foot # Terminal emulator (lightweight, good for templating)
    alacritty
    thunar
    
    # CLI Tools
    helix
    neovim
    matugen # Installed via inputs, or package overlay if needed
    tmux
    yazi
    fzf
    fish
    
    # Utils for Niri/Wayland
    brightnessctl
    pamixer
    networkmanagerapplet
    wl-clipboard
    grim # Screenshots
    slurp # Screenshots selection
  ];

  # Symlink Dotfiles (No Rebuild Strategy)
  # We manually define which folders to link.
  xdg.configFile = {
    "niri" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/afnix_dotfiles/dotfiles/niri";
    };
    "matugen" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/afnix_dotfiles/dotfiles/matugen";
    };
    "waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/afnix_dotfiles/dotfiles/waybar";
    };
  };

  # Basic Git Config 
  programs.git = {
    enable = true;
    settings = {
      user.name = "Rijalul Fikri";
      user.email = "asah.fikir@gmail.com";
    };
  };

  # Wlogout
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;
    layout = [
      {
        label = "lock";
        action = "hyprlock"; # Or swaylock
        text = "Lock";
        keybind = "l";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
    ];
  };

  # Session Variables (needed for Niri/Wayland)
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1"; # for VSCode/Electron apps
  };

  home.stateVersion = "24.05";
}
