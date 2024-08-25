{ config, pkgs, ... }:

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
