{
  description = "WSL NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations.elias = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        nixos-wsl.nixosModules.default
	home-manager.nixosModules.default
      ];
    };

    homeConfigurations.elias = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs;

      modules = [
        ./home.nix
      ];
    };
  };
}

