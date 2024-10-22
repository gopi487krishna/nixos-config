{inputs, config, pkgs, ... }:

{
  # Core home
  imports = 
  [
  	../../common/home.nix
	../../applications/wezterm/wezterm_config.nix
	../../applications/dunst/dunst_config.nix
  ];

  # For managing wallpapers
  home.packages = with  pkgs; [
    wl-clipboard
    onlyoffice-bin
    # Note : corefonts may not be available in only office so use this workaround to make it visible
    # https://nixos.wiki/wiki/Onlyoffice
    corefonts
  ];

  fonts.fontconfig.enable = true;
  programs.wezterm.enable = true;
  services.dunst.enable = true;


  # vscode pkgs,extensions
  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
  };

  gtk = {
    enable = true;
    theme = {
	name = "Catppuccin-Macchiato-Compact-Peach-Dark";
	package = pkgs.catppuccin-gtk.override {
		accents = [ "peach" ];
		size = "compact";
		tweaks = [ "rimless" "black" ];
		variant = "macchiato";
	};
    };
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
