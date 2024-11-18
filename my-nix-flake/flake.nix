{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;

      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    Hyprspace = {
    	url = "github:KZDKM/Hyprspace";
	inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { nixpkgs, home-manager,  ... } @ inputs:
  let
    lib  = nixpkgs.lib;
  in
  {
       nixosConfigurations = {
          nixos = lib.nixosSystem {
            specialArgs = { inherit inputs; };
            system = "x86_64-linux";
            modules = [
           ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.alias = ./home-manager/home.nix;
	      extraSpecialArgs = {inherit inputs;};
            };
          }
        ];
      };
    };
  };
}
