vim.cmd [[packadd packer.nvim]]

local packer_group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"packer.lua"},
    command = "source <afile> | PackerSync",
    group = packer_group,
})

local packer = require("packer")

local status_ok = pcall(require, "packer")
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    }
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "folke/tokyonight.nvim"
  use "ishan9299/nvim-solarized-lua"
  use "tpope/vim-vinegar"
  use "mbbill/undotree"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
end)
