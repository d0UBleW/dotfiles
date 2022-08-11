local M = {}

local function toggle_bg()
    local curr_bg = vim.api.nvim_get_option("background")
    if curr_bg == "dark" then
        curr_bg = "light"
    else
        curr_bg = "dark"
    end
    vim.opt.background = curr_bg
end

M.toggle_bg = toggle_bg

return M
