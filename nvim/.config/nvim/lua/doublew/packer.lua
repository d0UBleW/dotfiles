vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'ishan9299/nvim-solarized-lua'
  use 'tpope/vim-vinegar'
  use 'mbbill/undotree'
end)
