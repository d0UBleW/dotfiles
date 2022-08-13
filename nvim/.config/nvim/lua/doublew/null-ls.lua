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
            vim.api.nvim_command([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync() ]])
            vim.api.nvim_command([[ augroup END ]])
        end
    end,
    sources = {
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        diagnostics.flake8,
        diagnostics.eslint_d.with({
            diagnostics_format = "[eslint] #{m}\n{#{c}}",
        }),
    },
})
