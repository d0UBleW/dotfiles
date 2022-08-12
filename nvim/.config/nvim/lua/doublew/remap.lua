local nnoremap = require("doublew.keymap").nnoremap
local vnoremap = require("doublew.keymap").vnoremap
local cmap = require("doublew.keymap").cmap

cmap("<C-a>", "<home>")
cmap("<C-e>", "<end>")

nnoremap("-", "<cmd>Ex<CR>")

nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")

nnoremap("<tab>", "<cmd>tabnext<CR>")
nnoremap("<S-tab>", "<cmd>tabprevious<CR>")

nnoremap("[b", "<cmd>bprevious<CR>")
nnoremap("]b", "<cmd>bnext<CR>")

nnoremap("co", "<cmd>copen<CR>")
nnoremap("cc", "<cmd>cclose<CR>")

nnoremap("<F5>", "<cmd>lua require('doublew.toggle').toggle_bg()<CR>")

nnoremap("<leader>tf", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>tg", "<cmd>Telescope git_files<CR>")
nnoremap("<leader>ts", "<cmd>Telescope live_grep<CR>")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("<leader>p", '"_dP')
