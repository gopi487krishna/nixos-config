{inputs, config, pkgs, ... }:

{
  # Core home
	#  imports =
	#  [
	#  	../../common/home.nix
	# ../../applications/dunst/dunst_config.nix
	#  ];
	#
  # For managing wallpapers
  home.packages = with  pkgs; [
    neofetch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
