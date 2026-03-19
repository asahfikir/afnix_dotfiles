{
  description = "AsahFikir NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri Flake (using latest version)
    niri.url = "github:sodiboo/niri-flake";

    # Matugen (biar otomatis warna nya nanti dari wallpaper)
    matugen = {
      url = "github:InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, matugen, ...}@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the main system config
        ./system/configuration.nix
        
        # Import Niri module
        niri.nixosModules.niri

        # Setup HOme Manager as NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.fikri = import ./home/home.nix;
           
          # Pass inputs ke home-manager biar bisa akses matugen nanti
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
