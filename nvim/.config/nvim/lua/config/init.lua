require("config.autocmds")
require("config.colorscheme")
require("config.keymaps")
require("config.option")

vim.cmd([[ command! W execute 'lua require("util.sudo.write")("!")' ]])
