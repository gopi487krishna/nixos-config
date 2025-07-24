{inputs, config, pkgs, ... }:

{
  # Core home
  imports =
  [
  	../../common/home.nix
	../../applications/dunst/dunst_config.nix
  ];

  # For managing wallpapers
  home.packages = with  pkgs; [
    wl-clipboard
    onlyoffice-bin
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    # Note : corefonts may not be available in only office so use this workaround to make it visible
    # https://nixos.wiki/wiki/Onlyoffice
    corefonts
    gh
    joplin
    tea
    anytype
    obsidian
    aider-chat
    zellij
    watchexec
    libnotify
    zoom-us
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    weechat
  ];

  fonts.fontconfig.enable = true;
  services.dunst.enable = true;


  # vscode pkgs,extensions
  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
  };

  # Zoxide for cd command
  programs.zoxide.enable = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];

  # Enable zellij and provide fish integration
  # programs.zellij = {
  #   enable = true;
  #   enableFishIntegration = true;
  #   settings = {
  #     theme = "ayu_dark";
  #   };
  # };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
