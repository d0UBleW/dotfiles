local nnoremap = require("doublew.keymap").nnoremap
local vnoremap = require("doublew.keymap").vnoremap

nnoremap("-", "<cmd>Ex<CR>")

nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

nnoremap("<C-h>", "<cmd>wincmd h<CR>")
nnoremap("<C-j>", "<cmd>wincmd j<CR>")
nnoremap("<C-k>", "<cmd>wincmd k<CR>")
nnoremap("<C-l>", "<cmd>wincmd l<CR>")

nnoremap("<tab>", "<cmd>tabnext<CR>")
nnoremap("<S-tab>", "<cmd>tabprevious<CR>")

nnoremap("[b", "<cmd>bprevious<CR>")
nnoremap("]b", "<cmd>bnext<CR>")

nnoremap("co", "<cmd>copen<CR>")
nnoremap("cc", "<cmd>cclose<CR>")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("<leader>p", '"_dP')
