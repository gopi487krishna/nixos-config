{inputs, config, pkgs, ... }:
# Notification Daemon : Dunst config
{
  services.dunst = {
    settings = {
      global = {
        timeout = 10;
        separator_height = 2;
        corner_radius = 5;
	frame_color = "#ffd60aff";
	background = "#000814";
      };
   };
  };
}
