return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, lhs, rhs, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
                    map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
                    map("n", "<leader>gb", gs.blame_line, { desc = "Git blame line" })
                    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                end,
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
        },
    },
}
