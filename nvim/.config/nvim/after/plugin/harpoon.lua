local mark_status_ok, mark = pcall(require, "harpoon.mark")
local ui_status_ok, ui = pcall(require, "harpoon.ui")

if not (mark_status_ok and ui_status_ok) then
	return
end

local nnoremap = require("doublew.keymap").nnoremap

nnoremap("<leader>ma", mark.add_file, { desc = "[M]ark [A]dd file" })
nnoremap("<leader>e", ui.toggle_quick_menu)

nnoremap("<leader>1", function()
	ui.nav_file(1)
end)

nnoremap("<leader>2", function()
	ui.nav_file(2)
end)

nnoremap("<leader>3", function()
	ui.nav_file(3)
end)

nnoremap("<leader>4", function()
	ui.nav_file(4)
end)
