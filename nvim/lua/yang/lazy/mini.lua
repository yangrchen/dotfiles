return {
    {
        "nvim-mini/mini.nvim",
        version = "*",
        config = function()
            require("mini.comment").setup()
            require("mini.pairs").setup()
            require("mini.surround").setup()
            require("mini.files").setup({
                windows = {
                    preview = true,
                    width_preview = 50,
                },
            })

            vim.keymap.set("n", "<leader>p", function()
                require("mini.files").open()
            end, { desc = "Open mini.files" })

        end,
    },
}
