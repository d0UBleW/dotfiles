vim.opt.background = "light"

local t = os.date("*t").hour
if t >= 20 then
    vim.opt.background = "dark"
end


-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true
--
-- vim.g.solarized_italic_comments = false
-- vim.g.solarized_italic_keywords = false
-- vim.g.solarized_italic_functions = false
-- vim.g.solarized_italic_variables = false
-- vim.g.solarized_contrast = true
-- vim.g.solarized_borders = false
-- vim.g.solarized_disable_background = false
--
-- local scheme = "tokyonight"
-- local scheme = "solarized"

local neo_status_ok, neo = pcall(require, "neosolarized")

if not neo_status_ok then
    vim.notify("colorscheme neosolarized not found!")
    vim.cmd("colorscheme default")
end

neo.setup({
    comment_italics = true
})


-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
--
-- if not status_ok then
--     vim.notify("colorscheme " .. scheme .. " not found!")
--     vim.cmd("colorscheme default")
--     return
-- end
