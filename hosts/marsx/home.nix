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
    onlyoffice-bin
    # Note : corefonts may not be available in only office so use this workaround to make it visible
    # https://nixos.wiki/wiki/Onlyoffice
    corefonts
  ];

  fonts.fontconfig.enable = true;

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
