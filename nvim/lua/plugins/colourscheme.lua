return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}