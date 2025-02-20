{ inputs, config, pkgs, ... }:

{
  # Core home
  imports = 
  [
  	../../common/home.nix
	../../applications/dunst/dunst_config.nix
  ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  	# Custom Wrapper to make onlyoffice work with
	# xwayland-satellite 
  	(pkgs.symlinkJoin {
        	name = "onlyoffice-bin";
        	paths = [ pkgs.onlyoffice-bin ];
        	buildInputs = [ pkgs.makeWrapper ];
        	postBuild = ''
        	wrapProgram $out/bin/onlyoffice-desktopeditors \
        	--set DISPLAY :1
		mv $out/share/applications/onlyoffice-desktopeditors.desktop{,.orig}
		substitute $out/share/applications/onlyoffice-desktopeditors.desktop{.orig,}\
		--replace-fail Exec=${pkgs.onlyoffice-bin}/bin/onlyoffice-desktopeditors Exec=$out/bin/onlyoffice-desktopeditors 
        	'';
  	})
  ];


  fonts.fontconfig.enable = true;
  services.dunst.enable = true;

  programs.vscode = {
  	enable = true;
	extensions = with pkgs.vscode-extensions; [
		ms-vscode-remote.remote-ssh
		teabyii.ayu
	];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
