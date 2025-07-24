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
      # Custom waybar overlay
      ../../applications/waybar/waybar.nix
      # Custom rofi-wayland-unwrapped overlay
      ../../applications/rofi-unwrapped/rofi-unwrapped.nix
    ];

  networking.hostName = "venusx"; # Define your hostname.
  networking.wg-quick.interfaces.wg0.configFile = "/etc/nixos/files/wireguard/wg0.conf";
  networking.wg-quick.interfaces.wg0.autostart = false;


  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "nix-builder";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
  };

  # SSH extra
  programs.ssh = {
    extraConfig = ''
    Host *
    ConnectTimeout 10
    '';
  };


  # Firewall
  networking.firewall = {
  	enable = true;
  	allowedTCPPorts = [ 5258 4242 5901 6080];
	allowedUDPPorts = [ 4879 ];
  };

  # Bootloader.
  boot.loader = {
  	grub = {
		gfxpayloadEfi = "keep";

	};
  };


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # ddc util
  hardware.i2c.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "i2c-dev" "v4l2loopback" ];
  security.polkit.enable = true;
  programs.obs-studio.enableVirtualCamera = true;


  # RKVM client
  #services.rkvm.enable = true;
  #services.rkvm.client.enable = true;
  #services.rkvm.client.settings.server = "192.168.29.242:5258";
  #services.rkvm.client.settings.password="";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     waybar
     rofi-wayland-unwrapped
     mosh
     wireguard-tools
     niri
     surface-control
     qemu
     (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
     qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        "$@"
     '')
     inputs.ghostty.packages."${pkgs.system}".default
     alacritty
     shotcut
     ddcutil
     immersed-vr
     turbovnc
     wayvnc
     hyprpaper
     moonlight-qt
     rustlings
  ];
  services.displayManager.sessionPackages = [ pkgs.niri ];

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };


  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);



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

  xdg = {
    portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal
          pkgs.xdg-desktop-portal
          pkgs.xdg-desktop-portal-wlr
        ];
      };
  };

  # Graphics options
  nixpkgs.config.packageOverrides = pkgs: {
  intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.graphics = { 
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      libva
      vaapiVdpau
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  # Enable Docker
  # virtualisation.docker.enable = true;

}
