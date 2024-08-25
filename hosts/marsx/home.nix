{inputs, config, pkgs, ... }:

{
  # Core home
  imports = 
  [
  	../../common/home.nix
  ];

  # For managing wallpapers
  home.packages = with  pkgs; [
    hyprshot
  ];

  # vscode pkgs,extensions
  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
  };

  # wezterm config
  programs.wezterm = {
  	enable = true;
	package = inputs.wezterm.packages.${pkgs.system}.default;
  };


  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaSapphire;
      name = "catppuccin-mocha-sapphire-cursors";
      size = 32;
    };
  };

  home.pointerCursor = {
  	gtk.enable = true;
      	package = pkgs.catppuccin-cursors.mochaSapphire;
      	name = "catppuccin-mocha-sapphire-cursors";
  	size = 32;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
