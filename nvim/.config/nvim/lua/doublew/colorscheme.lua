vim.opt.background = "light"

local f = io.open('/home/d0ublew/.theme', 'rb')
if (f ~= nil) then
	local content = f:read("*all")
	vim.opt.background = content:gsub("%s+", "")
	f:close()
end

--[[ local time = os.date("*t").hour ]]
--[[ vim.opt.background = "light" ]]
--[[ if time > 17 or time < 6 then ]]
--[[ 	vim.opt.background = "dark" ]]
--[[ end ]]

vim.cmd([[ colorscheme tokyonight ]])
