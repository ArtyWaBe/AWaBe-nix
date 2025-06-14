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
		 desktop-nachko = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/desktop-nachko/configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.nachko = import ./home-manager/users/desktop-nachko.nix;
				}
			];
		 };
		 laptop-nachko = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/laptop-nachko/configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.nachko = import ./home-manager/users/laptop-nachko.nix;
				}
			];
		 };
    };
  };
}
