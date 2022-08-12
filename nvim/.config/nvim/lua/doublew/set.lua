local options = {
    title = true,

    termguicolors = true,
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
    mouse = "a",

    hidden = true,

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
    autoindent = true,

    hlsearch = false,
    incsearch = true,

    smartcase = true,
    ignorecase = true,

    wrap = false,
    linebreak = true,
    breakindent = true,

    belloff = "all",

    pumheight = 10,

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

    completeopt = { "menu", "menuone", "noselect" },

    laststatus = 2,
    confirm = true,
    showcmd = true,

    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,

    inccommand = "split",
    backspace = "start,eol,indent",
}

vim.opt.shortmess:append("c")

vim.g.mapleader = " "

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("set nostartofline")
