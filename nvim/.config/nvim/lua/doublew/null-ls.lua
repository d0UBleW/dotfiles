local null_status_ok, null_ls = pcall(require, "null-ls")

if not null_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_command([[ augroup FormatOnSave ]])
			vim.api.nvim_command([[ autocmd! * <buffer> ]])
			vim.api.nvim_command([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])
			vim.api.nvim_command([[ augroup END ]])
		end
	end,
	sources = {
		--[[ formatting.black.with({ extra_args = { "--fast" } }), ]]
		formatting.stylua,
		formatting.rubocop,
		formatting.markdownlint,
		formatting.prettierd,
		formatting.rustfmt.with({
			extra_args = function(params)
				local Path = require("plenary.path")
				local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

				if cargo_toml:exists() and cargo_toml:is_file() then
					for _, line in ipairs(cargo_toml:readlines()) do
						local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
						if edition then
							return { "--edition=" .. edition }
						end
					end
				end
				-- default edition when we don't find `Cargo.toml` or the `edition` in it.
				return { "--edition=2021" }
			end,
		}),

		diagnostics.flake8,
		diagnostics.yamllint,
		diagnostics.markdownlint,
		diagnostics.rubocop,
		diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n{#{c}}",
		}),
	},
})
