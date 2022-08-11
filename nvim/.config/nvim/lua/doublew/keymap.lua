local M = {}

local function bind(op, outer_opts)
	outer_opts = outer_opts or {noremap = true, silent = true}
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force",
			outer_opts,
			opts or {}
		)
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

M.nmap = bind("n", {noremap = false})
M.cmap = bind("c", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.cnoremap = bind("c")

local function buf_bind(op, outer_opts)
	outer_opts = outer_opts or {noremap = true, silent = true}
	return function(bufnr, lhs, rhs, opts)
		opts = vim.tbl_extend("force",
			outer_opts,
			opts or {}
		)
		vim.api.nvim_buf_set_keymap(bufnr, op, lhs, rhs, opts)
	end
end

M.buf_nnoremap = buf_bind("n")
M.buf_vnoremap = buf_bind("v")
M.buf_xnoremap = buf_bind("x")
M.buf_inoremap = buf_bind("i")
M.buf_cnoremap = buf_bind("c")

return M
