local wezterm = require("wezterm")
local config = {}

local time = os.date("*t").hour
if time > 17 or time < 6 then
	config.color_scheme = "tokyonight_storm"
else
	config.color_scheme = "tokyonight_day"
end

config.font = wezterm.font("Iosevka Term", { weight = "Regular", stretch = "Normal", style = "Normal" })

-- Disable ligature
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

--[[ config.window_background_image = "C:\\Users\\William\\Downloads\\test.jpg" ]]

--[[ config.window_background_image_hsb = { ]]
--[[ 	-- Darken the background image by reducing it to 1/3rd ]]
--[[ 	brightness = 0.1, ]]
--[[]]
--[[ 	-- You can adjust the hue by scaling its value. ]]
--[[ 	-- a multiplier of 1.0 leaves the value unchanged. ]]
--[[ 	hue = 1.0, ]]
--[[]]
--[[ 	-- You can adjust the saturation also. ]]
--[[ 	saturation = 1.0, ]]
--[[ } ]]

--[[ config.window_background_opacity = 0.95 ]]

config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"

config.hide_tab_bar_if_only_one_tab = true

-- Recommended to be disabled if using vim
config.use_dead_keys = false

config.use_fancy_tab_bar = false

config.keys = {
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action.ShowLauncher,
	},
}

return config
