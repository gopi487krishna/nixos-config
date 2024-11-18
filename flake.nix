{
	description = "System Flake";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		catppuccin.url = "github:catppuccin/nix";
		#wezterm.url = "github:wez/wezterm?dir=nix";
		#wezterm.inputs.nixpkgs.follows = "nixpkgs";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		gnexus-certs = {
			url = "git+ssh://git@github.com/gopi487krishna/nixos-certs.git?ref=main";
			flake = false;
		};
		agenix.url = "github:ryantm/agenix";
		nixos-secrets = {
			url = "git+ssh://git@github.com/gopi487krishna/nixos-secrets.git?ref=main";
			flake = false;
		};
		jaggernaut = {
			url = "git+ssh://git@github.com/gopi487krishna/jaggernaut-nix.git?ref=main";
		};  
	};

	outputs = { self, jaggernaut, agenix, nixos-secrets, gnexus-certs, catppuccin, nixpkgs, home-manager, nixos-hardware, ... } @ inputs:
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
				agenix.nixosModules.default
				./hosts/marsx/configuration.nix
				];
				specialArgs = {inherit inputs; inherit gnexus-certs; inherit nixos-secrets; inherit jaggernaut;};

			};
			titanx = lib.nixosSystem {
				inherit system;
				modules = [
				catppuccin.nixosModules.catppuccin
				agenix.nixosModules.default
				./hosts/titanx/configuration.nix
				];
				specialArgs = {inherit inputs; inherit gnexus-certs; inherit nixos-secrets; inherit jaggernaut;};
			};
			venusx = lib.nixosSystem {
				inherit system;
				modules = [
				catppuccin.nixosModules.catppuccin
				nixos-hardware.nixosModules.microsoft-surface-common
				agenix.nixosModules.default
				./hosts/venusx/configuration.nix
				];
				specialArgs = {inherit inputs; inherit gnexus-certs; inherit nixos-secrets; inherit jaggernaut;};
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
			"cooldev@venusx" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [
				./hosts/venusx/home.nix
				catppuccin.homeManagerModules.catppuccin
				];
				extraSpecialArgs = {inherit inputs;};
			};
		};
	};
}
