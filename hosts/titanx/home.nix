{ inputs, config, pkgs, ... }:

{
  # Core home
  imports = 
  [
  	../../common/home.nix
  ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hyprshot
  ];

  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
  };

  programs.wezterm = {
  	enable = true;
	package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  gtk = {
  	enable = true;
	cursorTheme = {
		package = pkgs.catppuccin-cursors.mochaDark;
		name = "catppuccin-mocha-dark-cursors";
		size = 24;
	};
  };

  home.pointerCursor = {
  	gtk.enable = true;
	package = pkgs.catppuccin-cursors.mochaDark;
	name = "catppuccin-moch-dark";
	size = 24;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
