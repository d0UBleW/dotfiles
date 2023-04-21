local wezterm = require("wezterm")
local config = {}

local time = os.date("*t").hour
if time > 17 or time < 6 then
	config.color_scheme = "tokyonight_storm"
else
	config.color_scheme = "tokyonight_day"
end

config.font = wezterm.font("Iosevka Term", {
	weight = "Medium",
	stretch = "Expanded",
	style = "Normal",
})

config.font_size = 11

-- Disable ligature
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

--[[ config.window_background_image = "C:\\Users\\William\\Downloads\\test.jpg"

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.1,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
} ]]

--[[ config.window_padding = { ]]
--[[ 	left = 0, ]]
--[[ 	right = 0, ]]
--[[ 	top = 0, ]]
--[[ 	bottom = 0, ]]
--[[ } ]]

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
	if overrides.color_scheme == "tokyonight_day" then
		overrides.color_scheme = "tokyonight_storm"
	else
		overrides.color_scheme = "tokyonight_day"
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.85
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "l",
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

return config
