require("doublew.set")
require("doublew.cursor")
require("doublew.notify")
require("doublew.remap")
require("doublew.packer")
require("doublew.lsp")

--[[ require("doublew.telescope") ]]
--[[ require("doublew.treesitter") ]]
--[[ require("doublew.treesitter-context") ]]
--[[ require("doublew.autopairs") ]]
--[[ require("doublew.autotag") ]]
--[[ require("doublew.comment") ]]
--[[ require("doublew.neogit") ]]
--[[ require("doublew.gitsigns") ]]
--[[ require("doublew.surround") ]]
--[[ require("doublew.null-ls") ]]
--[[ require("doublew.prettier") ]]
--[[ require("doublew.lualine") ]]
--[[ require("doublew.colorizer") ]]
--[[ require("doublew.trouble") ]]
--[[ require("doublew.project_nvim") ]]
--[[ require("doublew.indent-blankline") ]]
--[[ require("doublew.metals") ]]
--[[ require("doublew.fidget") ]]
--[[ require("doublew.ide") ]]

local ansible_group = vim.api.nvim_create_augroup("AnsibleFt", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		--[[ if vim.fn.search("hosts:\\|tasks:", "nw") > 0 then ]]
		if vim.fn.search("ansible.", "nw") > 0 then
			vim.api.nvim_command("set ft=yaml.ansible")
		end
	end,
	group = ansible_group,
})

local code_act_group = vim.api.nvim_create_augroup("CodeAction", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		local status_ok, code_action = pcall(require, "code_action_utils")
		if not status_ok then
			return
		end

		code_action.code_action_listener()
	end,
	group = code_act_group,
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
