{
	description = "Teo's streamlined NixOS + Home Manager setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/release-24.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, neovim-nightly-overlay, ... }@inputs:
	let
		system = "x86_64-linux";
		username = "teotoivo";

		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		};

		pkgsUnstable = import nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
	in {
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit username pkgsUnstable inputs;
				};
				modules = [
					./hosts/pc/configuration.nix
					./modules/core.nix
					./modules/hyprland.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.users.${username}.imports = [ ./home/pc.nix ];
					}
				];
			};

			laptop = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit username pkgsUnstable inputs;
				};
				modules = [
					./hosts/laptop/configuration.nix
					./modules/core.nix
					./modules/hyprland.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.users.${username}.imports = [ ./home/laptop.nix ];
					}
				];
			};
		};

		homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = {
				inherit pkgsUnstable;
			};
			modules = [ ./home/common.nix ];
		};
	};
}

