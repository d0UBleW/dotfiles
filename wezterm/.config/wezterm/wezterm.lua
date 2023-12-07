local wezterm = require("wezterm")
local config = {}

config.force_reverse_video_cursor = true

config.color_schemes = {
	["Kanagawa Lotus"] = {
		foreground = "#545464",
		background = "#f2ecbc",

		--[[ cursor_bg = "#43436c", ]]
		--[[ cursor_fg = "#43436c", ]]
		--[[ cursor_border = "#43436c", ]]

		selection_fg = "#43436c",
		selection_bg = "#9fb5c9",

		scrollbar_thumb = "#d5cea3",
		split = "#d5cea3",

		ansi = { "#1f1f28", "#c84053", "#6f894e", "#77713f", "#4d699b", "#b35b79", "#597b75", "#545464" },
		brights = { "#8a8980", "#d7474b", "#6e915f", "#836f4a", "#6693bf", "#624c83", "#5e857a", "#43436c" },
		indexed = { [16] = "#e98a00", [17] = "#e82424" },
	},
	["Kanagawa Wave"] = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		--[[ cursor_bg = "#c8c093", ]]
		--[[ cursor_fg = "#c8c093", ]]
		--[[ cursor_border = "#c8c093", ]]

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
}

--[[ local time = os.date("*t").hour
if time > 17 or time < 8 then
	config.color_scheme = "tokyonight_storm"
else
	config.color_scheme = "tokyonight_day"
end ]]

--[[ local time = os.date("*t").hour
if time > 17 or time < 8 then
	config.color_scheme = "Catppuccin Frappe"
else
	config.color_scheme = "Catppuccin Latte"
end ]]

local time = os.date("*t").hour
if time > 17 or time < 8 then
	config.color_scheme = "Kanagawa Wave"
else
	config.color_scheme = "Kanagawa Lotus"
end

config.font = wezterm.font("Iosevka Term", {
	weight = "Medium",
	stretch = "Expanded",
	style = "Normal",
})

config.font_size = 11

-- Disable ligature
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.window_background_opacity = nil

config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"

config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true

-- Recommended to be disabled if using vim
config.use_dead_keys = false

config.use_fancy_tab_bar = false

wezterm.on("toggle-mode", function(window, _)
	local overrides = window:get_config_overrides() or {}
	--[[ if overrides.color_scheme == "tokyonight_day" then
		overrides.color_scheme = "tokyonight_storm"
	else
		overrides.color_scheme = "tokyonight_day"
	end ]]

	--[[ if overrides.color_scheme == "Catppuccin Latte" then
		overrides.color_scheme = "Catppuccin Frappe"
	else
		overrides.color_scheme = "Catppuccin Latte"
	end ]]

	if overrides.color_scheme == "Kanagawa Lotus" then
		overrides.color_scheme = "Kanagawa Wave"
	else
		overrides.color_scheme = "Kanagawa Lotus"
	end
	overrides.force_reverse_video_cursor = true

	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.75
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "o",
		mods = "CTRL|ALT",
		action = wezterm.action.ShowLauncher,
	},
	{
		key = "m",
		mods = "CTRL|ALT",
		action = wezterm.action.EmitEvent("toggle-mode"),
	},
	{
		key = "b",
		mods = "CTRL|ALT",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400
config.show_update_window = true

config.ssh_domains = {
	{
		name = "kali",
		remote_address = "192.168.199.128",
		multiplexing = "WezTerm",
		username = "d0UBleW",
		remote_wezterm_path = "/usr/local/bin/wezterm",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\kali",
		},
	},
	{
		name = "dojo",
		remote_address = "dojo.pwn.college",
		multiplexing = "None",
		username = "hacker",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\pwn.college.key",
		},
	},
}

return config
