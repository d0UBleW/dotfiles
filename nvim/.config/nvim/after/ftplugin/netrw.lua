local keymap = require("util.keymaps")
local buf_nnoremap = keymap.buf_nnoremap

local bufremove_ok, bufremove = pcall(require, "mini.bufremove")
if bufremove_ok then
	buf_nnoremap(0, "<esc>", function()
		bufremove.delete(0, false)
	end, { desc = "Close NetRW (bufremove)" })
else
	buf_nnoremap(0, "<esc>", "<cmd>bd<cr>", { desc = "Close NetRW" })
end
