{inputs, config, pkgs, ... }:
{
  # wezterm config
  programs.wezterm = {
	package = pkgs.wezterm;
	extraConfig = ''
	local catppuccin_mocha = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
	catppuccin_mocha.background = '#000814'
	catppuccin_mocha.foreground = '#cdd6f4'
	return {
		color_schemes = {
		  ['Catppuccin Mocha'] = catppuccin_mocha,
		},
		color_scheme = "Catppuccin Mocha",
		front_end = "WebGpu",
		window_decorations = "NONE",
		enable_tab_bar = true,
		tab_bar_at_bottom = true,
		use_fancy_tab_bar = false,
		show_tabs_in_tab_bar = true,
		show_new_tab_button_in_tab_bar = false,
		--font = wezterm.font 'DejaVuSansMono',
		font_size = 13.50,
		window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}

	}
	'';
  };
}
