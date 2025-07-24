{inputs, config, pkgs, ... }:
# Notification Daemon : Dunst config
{
  services.dunst = {
    settings = {
      global = {
        timeout = 10;
        font = "JetBrainsMono Nerd Font Mono 10";
        separator_height = 2;
        corner_radius = 5;
	      frame_color = "#ffd60aff";
        width = "(0,2000)";
        height = "(0,2000)";
	      background = "#000814";
      };
   };
  };
}
