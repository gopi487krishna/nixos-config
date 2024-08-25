{
	description = "System Flake";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		catppuccin.url = "github:catppuccin/nix";
		wezterm.url = "github:wez/wezterm?dir=nix";
		wezterm.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, catppuccin, nixpkgs, home-manager, ... } @ inputs:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {
			marsx = lib.nixosSystem {
				inherit system;
				modules = [
				catppuccin.nixosModules.catppuccin
				./hosts/marsx/configuration.nix
				];

			};
			titanx = lib.nixosSystem {
				inherit system;
				modules = [
				catppuccin.nixosModules.catppuccin
				./hosts/titanx/configuration.nix
				];
			};
		};
		homeConfigurations = {
			"cooldev@marsx" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
				./hosts/marsx/home.nix 
				catppuccin.homeManagerModules.catppuccin
				];
				extraSpecialArgs = {inherit inputs;};
			};
			"cooldev@titanx" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [
				./hosts/titanx/home.nix
				catppuccin.homeManagerModules.catppuccin
				];
				extraSpecialArgs = {inherit inputs;};
			};
		};
	};
}
