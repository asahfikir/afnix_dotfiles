# afnix_dotfiles
This is a repo where I store my NixOS configuration and dotfiles. I like the declarative nature of NixOS and would like to try again this OS after sometime. So I build this repo taking inspiration from everywhere especially Hydenix Project where it's currently not maintained anymore. So, I think it'll be better if I create my own setup.

# Screenshots
![Nix Desktop](./screenshots/afnix_desktop.png)
![Nix App](./screenshots/afnix_terminal.png)
![Nix App](./screenshots/afnix_terminal2.png)

# How it works
This repo is intended as base flake configuration. You can change parts of the configuration to suit your needs. This repo is structured like this:
```
- afnix_dotfiles
  + dotfiles       # Here is the dotfiles for every folder inside, this will later be symlinked to the .config folder 
    + matugen
    + niri
    + waybar
  + home           # Home Manager folder - User specific configuration
  + scripts        # Mostly used for theming
  + system         # Nix System Wide Configuration
  - flake.nix      # Main flake file
  - flake.lock
```

## Bootloader
For bootloader I don't use systemd because I have some problem detecting my other linux partition. When I use grub all the problem gone. You can choose `systemd` again if you want. Just disable the `grub` and enable `systemd`.
And also I set my `configurationLimit` to 3 since my `/boot/EFI` partition is really small. Only `270MB`. Every time I use `nixos-build` it'll fill that partition really fast. So, I limit it to only `3`.

## Setup your home user and shell
Navigate to `system/configuration.nix` and find `# User Account` then change `fikri` to your own chosen username.

Set the `shell = pkgs.fish` to your own preferred shell. I prefer fish as my default shell since the default is already really nice. Please add also the shell inside `environment.systemPackages` if you change the shell from `fish`.

## Timezone
My timezone is `Asia/Jakarta`. If  you have different timezone, search for `time.timeZone` and change the value to your preferred timezone.

## Installing Packages
If you want a system wide package installed to your system navigate to `system/configuration.nix` and search for `environment.systemPackages` then add your preferred application to install. To know the name of the package you can search via [Nix Package Official Website](https://search.nixos.org/packages).

## Theming
To set the desktop theme I'm utilizing `matugen` to extract colors from the wallpaper then I apply that color to my `Niri` and `waybar` colors. To set the theme, you need to have a `Wallpapers` folder inside your `~/Pictures` folder. Put all your wallpaper there and run this script:
```bash
./scripts/theme-switcher.sh ~/Pictures/Wallpapers/GreenLush_12.png
```

In my screenshots I'm using wallpapers from [Project Hyde - Green Lush](https://github.com/abenezerw/Green-Lush/). I only took the wallpaper since that theme is for Project Hyde which is for Hyprland, while this dotfiles is intended for Niri.

## TODOS
[-] Create a theme switcher UI attached to waybar
