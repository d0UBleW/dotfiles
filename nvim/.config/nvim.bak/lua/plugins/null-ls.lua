return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local null_status_ok, null_ls = pcall(require, "null-ls")

			if not null_status_ok then
				return
			end

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local on_attach = function(client, bufnr)
				if client.name == "tsserver" then
					client.server_capabilities.documentFormattingProvider = false
				end
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end

			return {
				debug = false,
				on_attach = on_attach,
				sources = {
					formatting.clang_format.with({
						extra_args = { "-style", "{IndentWidth: 4, AllowShortFunctionsOnASingleLine: Empty}" },
						--[[ extra_filetypes = { "arduino" }, ]]
					}),
					formatting.autopep8.with({
						extra_args = { "--aggressive", "--aggressive", "--aggressive" },
					}),
					formatting.isort,
					formatting.cmake_format,
					formatting.stylua,
					formatting.rubocop,
					formatting.markdownlint.with({
						extra_args = { "--disable", "MD014" },
						filetypes = { "md" },
					}),
					-- formatting.prettierd.with({
					-- 	--[[ disabled_filetypes = { "md", "markdown" }, ]]
					-- }),
					formatting.gofumpt,
					formatting.goimports,
					formatting.goimports_reviser,
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

					--[[ diagnostics.clang_check.with({ ]]
					--[[ 	extra_filetypes = { "arduino" }, ]]
					--[[ }), ]]
					diagnostics.clang_check,
					diagnostics.flake8,
					diagnostics.mypy,
					diagnostics.ansiblelint.with({
						filetypes = { "yaml.ansible" },
					}),
					diagnostics.yamllint,
					diagnostics.markdownlint.with({
						extra_args = { "--disable", "MD014" },
					}),
					--[[ diagnostics.rubocop, ]]
					--[[ diagnostics.eslint_d.with({ ]]
					--[[ 	diagnostics_format = "[eslint] #{m}\n{#{c}}", ]]
					--[[ }), ]]
					diagnostics.shellcheck,
					diagnostics.golangci_lint,
					diagnostics.cmake_lint,

					code_actions.refactoring,
					code_actions.gitsigns,
				},
			}
		end,
	},
}
