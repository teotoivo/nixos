
{
	description = "Teo's modular NixOS + Home Manager setup";

	inputs = {
		nixpkgs.url        = "github:NixOS/nixpkgs/nixos-24.05";
		home-manager.url   = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }:
	let
		supportedSystems = ["x86_64-linux" "aarch64-linux"];
		username = "teotoivo";
	in
	{
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit username; };
				modules = [
					./hosts/pc/configuration.nix
					./modules/core.nix
					./modules/hyprland.nix
					home-manager.nixosModules.home-manager
					{ home-manager.users.${username}.imports = [ ./home/pc.nix ]; }
				];
			};

			laptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit username; };
				modules = [
					./hosts/laptop/configuration.nix
					./modules/core.nix
					./modules/hyprland.nix
					home-manager.nixosModules.home-manager
					{ home-manager.users.${username}.imports = [ ./home/laptop.nix ]; }
				];
			};
		};

		homeConfigurations.${username} =
			home-manager.lib.homeManagerConfiguration {
				pkgs = import nixpkgs { system = "x86_64-linux"; };
				modules = [ ./home/common.nix ];
			};
	};
}

