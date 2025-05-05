{
	description = "Teo's modular NixOS + Home Manager setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/release-24.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, neovim-nightly-overlay, nixpkgs-mozilla, ... }@inputs:
	let
		username = "teotoivo";
		supported_systems = [ "x86_64-linux" "aarch64-linux" ];

		for_each_system = nixpkgs.lib.genAttrs supported_systems (system:
			let
				pkgs = import nixpkgs {
					inherit system;
					config.allowUnfree = true;
				};
				pkgs_unstable = import nixpkgs-unstable {
					inherit system;
					config.allowUnfree = true;
				};
			in {
				inherit pkgs pkgs_unstable;
			}
		);
	in {
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {
					inherit username;
					pkgsUnstable = for_each_system."x86_64-linux".pkgs_unstable;
					inputs = inputs;
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
				system = "x86_64-linux";
				specialArgs = {
					inherit username;
					pkgsUnstable = for_each_system."x86_64-linux".pkgs_unstable;
					inputs = inputs;
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
			pkgs = for_each_system."x86_64-linux".pkgs;
			extraSpecialArgs = {
				pkgsUnstable = for_each_system."x86_64-linux".pkgs_unstable;
			};
			modules = [ ./home/common.nix ];
		};
	};
}

