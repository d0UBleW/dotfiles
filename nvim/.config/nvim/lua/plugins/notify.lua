return {
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "#000000",
            fps = 60,
            render = "default",
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        config = function(_, opts)
            require("notify").setup(opts)
            vim.notify = require("notify")
        end,
        keys = function()
            local lazy_keymap = require("doublew.keymap").lazy_keymap
            return {
                lazy_keymap("<C-l>", function()
                    require("notify").dismiss({ silent = true, pending = true })
                end, {
                    mode = "n",
                    desc = "Dismiss notification",
                })
            }
        end,
    },
}
