{inputs, jaggernaut, config, pkgs, ... }:

{

  home.username = "cooldev";
  home.homeDirectory = "/home/cooldev";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs = {
	config = {
		allowUnfree = true;
		allowUnfreePredicate = (_: true);
	};
  };

  # Jaggernaut
  nixpkgs.overlays = [
  	jaggernaut.overlays.default
  ];



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
    nvim-pkg
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
