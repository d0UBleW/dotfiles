local status_ok_km, keymap = pcall(require, "doublew.keymap")

if not status_ok_km then
	return
end

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local cmap = keymap.cmap

cmap("<C-a>", "<home>")
cmap("<C-e>", "<end>")

nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

nnoremap("-", vim.cmd.Ex)

nnoremap("<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree" })
nnoremap("<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle [W]rap" })

nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")

nnoremap("<S-l>", "<cmd>tabnext<CR>")
nnoremap("<S-h>", "<cmd>tabprevious<CR>")
nnoremap("te", "<cmd>tabedit<CR>")

nnoremap("co", "<cmd>copen<CR>")
nnoremap("cc", "<cmd>cclose<CR>")
nnoremap("cn", "<cmd>cnext<CR>")
nnoremap("cp", "<cmd>cprev<CR>")

--[[ nnoremap("<leader>j", "<cmd>lprev<CR>zz") ]]
--[[ nnoremap("<leader>k", "<cmd>lnext<CR>zz") ]]

nnoremap("<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>")
nnoremap("<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true })

vnoremap("<C-j>", "J")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("<leader>p", '"_dP')

vim.api.nvim_create_user_command("IDE", function(_)
	require("doublew.ide")
end, { desc = "Enable IDE" })
