{ config, pkgs, ...}:

{
  imports = [
    # This is generated using `sudo nixos-generate-config --show-hardware-config`
    ./hardware-configuration.nix
  ];

  
  # Bootloader - we're using Grub Here to support Multi OS boot
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true; # Ini yang bikin CachyOS/Windows bisa muncul
      configurationLimit = 3; # EFI Partition nya kecil, jadi 3 aja
    };
  };

  # Auto cleanup untuk EFI
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Networking
  networking.networkmanager.enable = true;

  # Hardware Graphics (Renamed from opengl)
  nixpkgs.config.allowUnfree = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Timezone
  time.timeZone = "Asia/Jakarta";

  # XDG Portal fix for the warning
  # Essential for Wayland Compositors (Niri)
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };

  # Audio (Pipewire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.niri.enable = true;

  # Polkit is needed for GUI authentication prompts
  security.polkit.enable = true;

  programs.fish.enable = true;
  programs.starship.enable = true;
  
  # User Account
  users.users.fikri = { 
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
    shell = pkgs.fish;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    vim 
    wget 
    git
    curl
    fuzzel # app launcher
    slack
    alsa-utils
    starship
    psmisc
    lm_sensors # untuk sensor temperatur
    gh # for github cli

    swww # untuk ganti2 wallpaper
  ];

  # Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05"; 

}
