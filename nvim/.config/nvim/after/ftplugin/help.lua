local keymap = require("util.keymaps")
local buf_nnoremap = keymap.buf_nnoremap

buf_nnoremap(0, "<esc>", "<cmd>bd<cr>", { desc = "Close NetRW" })
