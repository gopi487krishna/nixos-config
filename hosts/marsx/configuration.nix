#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Common configuration
      ../../common/core.nix
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

  services.displayManager.sddm = {
  	# Surface pro is high DPI
	enableHidpi = true;
	settings = {
		General = {
		      GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=3,QT_FONT_DPI=192";
		};
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
  services.rkvm.client.settings.server = "192.168.29.242:5258";


  nixpkgs.overlays = [(final: super: {
    rofi-wayland-unwrapped = super.rofi-wayland-unwrapped.overrideAttrs({ patches ? [], ... }: {
      patches = patches ++ [
        (final.fetchpatch {
          url = "https://github.com/samueldr/rofi/commit/55425f72ff913eb72f5ba5f5d422b905d87577d0.patch";
          hash = "sha256-vTUxtJs4SuyPk0PgnGlDIe/GVm/w1qZirEhKdBp4bHI=";
        })
      ];
    });
  })];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     waybar
     hyprpaper
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
