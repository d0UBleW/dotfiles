local wezterm = require("wezterm")
local config = {}

config.force_reverse_video_cursor = true

local rose_pine_dawn = require("rose-pine-dawn").colors()
local rose_pine_moon = require("rose-pine-moon").colors()

local everforest_light = wezterm.color.get_builtin_schemes()["Everforest Light (Gogh)"]
everforest_light.cursor_bg = nil
everforest_light.cursor_fg = nil

local everforest_dark = wezterm.color.get_builtin_schemes()["Everforest Dark (Gogh)"]
everforest_dark.cursor_bg = nil
everforest_dark.cursor_fg = nil

config.color_schemes = {
	["rose-pine-dawn"] = rose_pine_dawn,
	["rose-pine-moon"] = rose_pine_moon,
	["Everforest Light"] = everforest_light,
	["Everforest Dark"] = everforest_dark,
	["Kanagawa Lotus"] = {
		foreground = "#545464",
		background = "#f2ecbc",

		--[[ cursor_bg = "#43436c", ]]
		--[[ cursor_fg = "#43436c", ]]
		cursor_border = "#43436c",

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
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},

	["GitHub-Light"] = {
		background = "#ffffff",
		cursor_bg = "#044289",
		cursor_border = "#044289",
		cursor_fg = "#ffffff",
		foreground = "#24292f",
		selection_bg = "#dbe9f9",
		selection_fg = "#24292f",
		ansi = {
			"#24292e",
			"#d73a49",
			"#28a745",
			"#dbab09",
			"#0366d6",
			"#5a32a3",
			"#0598bc",
			"#6a737d",
		},
		brights = {
			"#959da5",
			"#cb2431",
			"#22863a",
			"#b08800",
			"#005cc5",
			"#5a32a3",
			"#3192aa",
			"#d1d5da",
		},
		indexed = { [16] = "#b08800", [17] = "#cb2431" },
	},

	["GitHub-Dark"] = {
		background = "#24292e",
		cursor_bg = "#c8e1ff",
		cursor_border = "#c8e1ff",
		cursor_fg = "#24292e",
		foreground = "#d1d5da",
		selection_bg = "#284566",
		selection_fg = "#d1d5da",
		ansi = {
			"#586069",
			"#ea4a5a",
			"#34d058",
			"#ffea7f",
			"#2188ff",
			"#b392f0",
			"#39c5cf",
			"#d1d5da",
		},
		brights = {
			"#959da5",
			"#f97583",
			"#85e89d",
			"#ffea7f",
			"#79b8ff",
			"#b392f0",
			"#56d4dd",
			"#fafbfc",
		},
		indexed = { [16] = "#ffea7f", [17] = "#f97583" },
	},
}

local time = os.date("*t").hour

-- tokyonight_storm
-- tokyonight_day
-- rose-pine-moon
-- rose-pine-dawn
local light_scheme = "tokyonight_day"
local dark_scheme = "tokyonight_storm"

if time > 17 or time < 8 then
	config.color_scheme = dark_scheme
else
	config.color_scheme = light_scheme
end

config.font = wezterm.font_with_fallback({
	{
		family = "Iosevka Term",
		weight = "Medium",
		-- stretch = "Expanded",
		style = "Normal",
	},
	{
		family = "Iosevka NF",
		weight = "Medium",
		-- stretch = "Expanded",
		style = "Normal",
	},
})

config.font_size = 10

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

	if overrides.color_scheme == light_scheme then
		overrides.color_scheme = dark_scheme
	else
		overrides.color_scheme = light_scheme
	end

	-- overrides.force_reverse_video_cursor = true

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

-- config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }

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
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "z",
		mods = "CTRL|ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
}

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400
config.show_update_window = true

config.ssh_domains = {
	--[[ {
		name = "kali",
		remote_address = "192.168.199.132",
		multiplexing = "WezTerm",
		username = "d0UBleW",
		remote_wezterm_path = "/usr/local/bin/wezterm",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\kali",
		},
	}, ]]
	--[[ {
		name = "kali",
		remote_address = "192.168.199.132",
		multiplexing = "None",
		username = "d0UBleW",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\kali",
		},
	}, ]]
	{
		name = "void",
		remote_address = "192.168.37.166",
		multiplexing = "None",
		username = "d0ublew",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\void",
		},
	},
	{
		name = "kali-hyperv",
		remote_address = "172.21.95.220",
		multiplexing = "None",
		username = "kali",
		ssh_option = {
			identityfile = "C:\\Users\\William\\.ssh\\kali-hyperv",
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
