local time = os.date("*t").hour
vim.opt.background = "light"
if time > 17 or time < 6 then
	vim.opt.background = "dark"
end

vim.cmd([[ colorscheme kanagawa ]])
