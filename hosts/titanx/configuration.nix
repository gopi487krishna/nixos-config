#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{inputs, gnexus-certs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Common config
      ../../common/core.nix
      # Waybar overlay
      ../../applications/waybar/waybar.nix
      # Custom rofi-wayland-unwrapped overlay
      ../../applications/rofi-unwrapped/rofi-unwrapped.nix
    ];


  networking.hostName = "titanx"; # Define your hostname.

    # Firewall
  networking.firewall = {
  	enable = true;
  	allowedTCPPorts = [ 5258 4242];
	allowedUDPPorts = [ 4879 ];
  };

  # Catppuccin
  boot.loader.grub.catppuccin.enable = true;
  boot.loader.grub.catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # RKVM stuff
  services.rkvm.enable = true;
  services.rkvm.server.enable = true;
  services.rkvm.server.settings.password = "";
  services.rkvm.server.settings.switch-keys = [ "caps-lock" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     waybar
     kitty
     rofi-wayland-unwrapped
     mosh
     niri
  ];


   fonts.fonts = with pkgs; [
     corefonts
  ];

  services = {
  	displayManager.sessionPackages = [ pkgs.niri ]; 
  	openssh.enable = true;
	xserver = {
		enable = true;
		videoDrivers = [ "nvidia" ];
	};
  };

  hardware = {
  	graphics.enable = true;
	nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
	};
  };

  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
  };
}
