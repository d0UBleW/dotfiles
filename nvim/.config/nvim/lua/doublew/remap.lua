local nnoremap = require("doublew.keymap").nnoremap

nnoremap("-", "<cmd>Ex<CR>")

nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

nnoremap("<C-h>", "<cmd>wincmd h<CR>")
nnoremap("<C-j>", "<cmd>wincmd j<CR>")
nnoremap("<C-k>", "<cmd>wincmd k<CR>")
nnoremap("<C-l>", "<cmd>wincmd l<CR>")

nnoremap("<tab>", "<cmd>tabnext<CR>")
nnoremap("<S-tab>", "<cmd>tabprevious<CR>")
