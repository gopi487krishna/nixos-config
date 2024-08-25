# Common environment packages and settings for every host

{inputs, config, pkgs, ... }:

{

  # Bootloader : We prefer grub for each system
  boot.loader = {
  	systemd-boot.enable = false;
	efi.canTouchEfiVariables = true;
  	grub = {
		enable = true;
		device = "nodev";
		efiSupport = true;

	};
  };



  # Display Manager : Our preference is sddm on all systems
  services.displayManager.sddm = {
  	enable = true;
	package = pkgs.kdePackages.sddm;
  };



  # We prefer network manager everywhere
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # cooldev must exist on all of my systems
  users.users.cooldev = {
    isNormalUser = true;
    description = "Gopi Krishna Menon";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System Packages. May need to override this to add important sys packages
  # for perticular host 
  environment.systemPackages = with pkgs; [
     wget
     firefox
     fastfetch
  ];


  # Important fonts. Preference DroidSansMono
  fonts.packages = with pkgs; [
  	font-awesome
  	noto-fonts
	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

   # Enable autoupgrades
  system.autoUpgrade.enable = true;

  # We prefer wayland everywhere

  services.xserver = {
  	enable = true;
  };

  hardware = {
  	graphics.enable = true;
	# Prefer wireplumber everywhere
	pulseaudio.enable = false;
  };

  # Some apps do require this to start in wayland
  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
  	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Pipewire settings
  services.pipewire = {
  	enable = true;
	audio.enable = true;
	pulse.enable = true;
	wireplumber.enable = true;
  };

  # Nix Version and Flakes

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Flakes Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
