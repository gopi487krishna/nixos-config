# Common environment packages and settings for every host

{inputs, jaggernaut, nixos-secrets, gnexus-certs, config, pkgs, ... }:

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


  # Jaggernaut
  nixpkgs.overlays = [
  	jaggernaut.overlays.default
  ];


  # Display Manager : Our preference is ly on all systems
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
    };
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

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    #variant = "colemak_dh";
  };

  # cooldev must exist on all of my systems
  users.users.cooldev = {
    isNormalUser = true;
    description = "Gopi Krishna Menon";
    extraGroups = [ "networkmanager" "wheel" "audio" "video"];
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
     xwayland-satellite
     inputs.agenix.packages.${system}.default
     nvim-pkg
  ];



  # Important fonts. Preference DroidSansMono
  fonts.packages = with pkgs; [
  	font-awesome
  	noto-fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # System wide fish shell support
  programs.fish.enable = true;

  programs.bash = {
  interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  };

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

  # Homelab CA
  security.pki.certificateFiles = [
  	"${gnexus-certs}/gnexus-labs-ca.pem"
  ];

  age.identityPaths = [ "/etc/ssh/ssh_private_key" ];
  age.secrets = {
  	"test" = {
		file = "${nixos-secrets}/test.age";
	};
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
