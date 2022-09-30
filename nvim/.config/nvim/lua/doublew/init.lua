require("doublew.set")
require("doublew.remap")
require("doublew.packer")
require("doublew.lsp")
require("doublew.telescope")
require("doublew.treesitter")
require("doublew.treesitter-context")
require("doublew.autopairs")
require("doublew.autotag")
require("doublew.comment")
require("doublew.neogit")
require("doublew.gitsigns")
require("doublew.surround")
require("doublew.null-ls")
require("doublew.prettier")
require("doublew.lualine")
require("doublew.colorizer")
require("doublew.trouble")

local ansible_group = vim.api.nvim_create_augroup("AnsibleFt", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		if vim.fn.search("hosts:\\|tasks:", "nw") > 0 then
			vim.api.nvim_command("set ft=yaml.ansible")
		end
	end,
	group = ansible_group,
})
