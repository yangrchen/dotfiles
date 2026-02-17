return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            -- Install parsers
            require("nvim-treesitter").install({
                "lua",
                "javascript",
                "typescript",
                "tsx",
                "python",
                "html",
                "css",
                "json",
                "yaml",
                "markdown",
                "markdown_inline",
            })

            -- Enable highlight and indent via vim.treesitter
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local ok = pcall(vim.treesitter.start)
                    if not ok then return end
                end,
            })

            -- Textobjects (nvim-treesitter-textobjects still uses its own setup)
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                },
            })
        end,
    },
}
