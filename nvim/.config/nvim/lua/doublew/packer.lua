vim.cmd([[packadd packer.nvim]])

local packer_group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "packer.lua" },
	command = "source <afile> | PackerSync",
	group = packer_group,
})

local packer = require("packer")

local status_ok = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	use("ThePrimeagen/git-worktree.nvim")
	use("ThePrimeagen/harpoon")

	use("folke/tokyonight.nvim")
	-- use("ishan9299/nvim-solarized-lua")
	use("shaunsingh/solarized.nvim")
	use({
		"svrana/neosolarized.nvim",
		requires = { "tjdevries/colorbuddy.nvim" },
	})

	use("tpope/vim-vinegar")

	use("mbbill/undotree")

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("onsails/lspkind-nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("TimUntersberger/neogit")
	use("lewis6991/gitsigns.nvim")

	use("kylechui/nvim-surround")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("norcalli/nvim-colorizer.lua")

	use("tpope/vim-unimpaired")
end)
