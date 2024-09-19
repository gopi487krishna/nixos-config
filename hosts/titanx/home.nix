{ inputs, config, pkgs, ... }:

{
  # Core home
  imports = 
  [
  	../../common/home.nix
	../../applications/wezterm/wezterm_config.nix
	../../applications/dunst/dunst_config.nix
  ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    pkgs.onlyoffice-bin
  ];


  fonts.fontconfig.enable = true;
  programs.wezterm.enable = true;
  services.dunst.enable = true;

  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
