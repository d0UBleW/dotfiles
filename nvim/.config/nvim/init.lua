-- Heavily inspired by LazyVim (https://github.com/LazyVim/LazyVim)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.extras.coding.spider" },
		{ import = "plugins.extras.lang.clangd" },
		{ import = "plugins.extras.lang.go" },
		{ import = "plugins.extras.lang.nim" },
	},
})
require("config")
