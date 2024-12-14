#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, gnexus-certs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Common configuration
      ../../common/core.nix
      # Waybar overlay
      ../../applications/waybar/waybar.nix
      # Custom rofi-wayland-unwrapped overlay
      ../../applications/rofi-unwrapped/rofi-unwrapped.nix
    ];

  
  networking.hostName = "marsx"; # Define your hostname.
  networking.wg-quick.interfaces.wg0.configFile = "/etc/nixos/files/wireguard/wg0.conf";
  networking.wg-quick.interfaces.wg0.autostart = false;


  # Firewall
  networking.firewall = {
  	enable = true;
  	allowedTCPPorts = [ 5258 4242];
	allowedUDPPorts = [ 4879 ];
  };

  # Bootloader.
  boot.loader = {
  	grub = {
		catppuccin.enable = true;
		catppuccin.flavor = "mocha";
		gfxpayloadEfi = "keep";
		gfxmodeEfi = "640x480";

	};
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;


  # Homelab CA
  security.pki.certificateFiles = [
  	/etc/nixos/files/homelab/gnexus-labs-ca.pem
  ];

  # Enable catppuccin globally
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # RKVM client
  services.rkvm.enable = true;
  services.rkvm.client.enable = true;
  services.rkvm.client.settings.password = "";
  services.rkvm.client.settings.server = "192.168.29.242:5258";


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     waybar
     kitty
     rofi-wayland-unwrapped
     mosh
     wireguard-tools
     niri
     swaybg
  ];
  services.displayManager.sessionPackages = [ pkgs.niri ];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
  };


  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
  };

  services.printing.enable = true;
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
  };

  services.printing.drivers = [ pkgs.cnijfilter2 ];
}
