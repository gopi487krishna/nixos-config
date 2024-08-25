#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Common config
      ../../common/core.nix
      # Networking info
      ../../private/hosts/titanx/networking.nix
    ];


  networking.hostName = "titanx"; # Define your hostname.

  # Catppuccin
  boot.loader.grub.catppuccin.enable = true;
  boot.loader.grub.catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # Homelab CA
  security.pki.certificateFiles = [
   ../../gnexus-labs-ca.pem
  ];

  # RKVM stuff
  services.rkvm.enable = true;
  services.rkvm.server.enable = true;
  services.rkvm.server.settings.password = builtins.readFile ../../private/rkvm_password;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     waybar
     hyprpaper
     kitty
     rofi-wayland-unwrapped
     mosh
  ];

  services = {
  	openssh.enable = true;
	xserver = {
		enable = true;
		videoDrivers = [ "nvidia" ];
	};
  };

  hardware = {
  	graphics.enable = true;
	nvidia.modesetting.enable = true;
  };

  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
  };
}
