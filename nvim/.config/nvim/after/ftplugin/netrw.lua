local keymap = require("util.keymaps")

local nnoremap = keymap.nnoremap

nnoremap("<esc>", "<cmd>bd<cr>", { desc = "Close NetRW" })
