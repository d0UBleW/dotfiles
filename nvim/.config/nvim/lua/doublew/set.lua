local options = {
	termguicolors = true,
    guicursor = "",
    mouse = "a",

	clipboard = "unnamedplus",

	backup = false,
	swapfile = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
	autowrite = true,

	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,

    smartindent = true,

    hlsearch = false,
    incsearch = true,

    smartcase = true,
    ignorecase = true,

    wrap = false,
    linebreak = true,

	belloff = "all",

	number = true,
	relativenumber = true,
    signcolumn = "yes",
    cursorline = true,
    colorcolumn = "80",

    errorbells = false,

    cmdheight = 1,
    updatetime = 50,

    splitbelow = true,
    splitright = true,

    conceallevel = 0,

    scrolloff = 8,
    sidescrolloff = 8,
}

vim.opt.shortmess:append("c")

vim.g.mapleader = " "

for k, v in pairs(options) do
	vim.opt[k] = v
end
