{
 description = "God's flake";

 inputs = {
 		# NixOS official package repo,
 		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
 		home-manager = {
 			url  = "github:nix-community/home-manager";
 			inputs.nixpkgs.follows = "nixpkgs";
 		};
 	};

	outputs =  inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations = {
		 desktop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/desktop/configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.nachko = import ./home-manager/users/desktop-nachko.nix;
					home.stateVersion = "25.05";
				}
			];
		 };
		 laptop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/laptop/configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.nachko = import ./home-manager/users/laptop-nachko.nix;
					home.stateVersion = "25.05";
				}
			];
		 };
    };
  };
}
