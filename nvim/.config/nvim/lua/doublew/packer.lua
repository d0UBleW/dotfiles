local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim" .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

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
	use({ "neovim/nvim-lspconfig", requires = {
		"j-hui/fidget.nvim",
	} })
	use("williamboman/nvim-lsp-installer")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cond = vim.fn.executable("make") == 1,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter-context", after = "nvim-treesitter" })
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("numToStr/Comment.nvim")
	use("tpope/vim-sleuth")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("TimUntersberger/neogit")
	use("lewis6991/gitsigns.nvim")

	use("kylechui/nvim-surround")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("kyazdani42/nvim-web-devicons")

	use("norcalli/nvim-colorizer.lua")

	use("tpope/vim-unimpaired")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use("ahmedkhalf/project.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	use({
		"scalameta/nvim-metals",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})

	use({
		"mfussenegger/nvim-dap",
	})
	use("rcarriga/nvim-dap-ui")
	use("rcarriga/nvim-notify")

	use({ "ldelossa/nvim-ide", require = {
		{ "DNLHC/glance.nvim" },
	} })
end)
