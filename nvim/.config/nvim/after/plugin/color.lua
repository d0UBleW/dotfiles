--[[ vim.opt.background = "light" ]]
vim.opt.background = "dark"

--[[ local t = os.date("*t").hour ]]
--[[ if true then ]]
--[[ 	vim.opt.background = "dark" ]]
--[[ 	local neo_status_ok, neo = pcall(require, "neosolarized") ]]
--[[ 	if not neo_status_ok then ]]
--[[ 		vim.notify("colorscheme neosolarized not found!") ]]
--[[ 		vim.cmd("colorscheme default") ]]
--[[ 	else ]]
--[[ 		neo.setup({ ]]
--[[ 			comment_italics = true, ]]
--[[ 		}) ]]
--[[ 	end ]]
--[[ else ]]
--[[ 	local sol_status_ok, sol = pcall(require, "solarized") ]]
--[[ 	if not sol_status_ok then ]]
--[[ 		vim.notify("colorscheme solarized not found!") ]]
--[[ 		vim.cmd("colorscheme default") ]]
--[[ 	else ]]
--[[ 		vim.g.solarized_italic_comments = false ]]
--[[ 		vim.g.solarized_italic_keywords = false ]]
--[[ 		vim.g.solarized_italic_functions = false ]]
--[[ 		vim.g.solarized_italic_variables = false ]]
--[[ 		vim.g.solarized_contrast = true ]]
--[[ 		vim.g.solarized_borders = false ]]
--[[ 		vim.g.solarized_disable_background = false ]]
--[[ 		sol.set() ]]
--[[ 	end ]]
--[[ end ]]

vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true

local time = os.date("*t").hour
local scheme = "tokyonight"
if time > -1 then
	scheme = scheme .. "-storm"
else
	scheme = scheme .. "-day"
end
-- local scheme = "solarized"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)

if not status_ok then
	vim.notify("colorscheme " .. scheme .. " not found!")
	vim.cmd("colorscheme default")
	return
end
