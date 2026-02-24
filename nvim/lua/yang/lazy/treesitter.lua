return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash", "c", "cpp", "css", "go", "html", "javascript",
        "json", "lua", "markdown", "markdown_inline", "python",
        "rust", "toml", "tsx", "typescript", "yaml",
      })

      -- Highlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function() pcall(vim.treesitter.start) end,
      })

      -- Folding
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldenable = false
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main", -- required: new API lives on main, not master
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local select = require("nvim-treesitter-textobjects.select")
      local move   = require("nvim-treesitter-textobjects.move")
      local swap   = require("nvim-treesitter-textobjects.swap")

      -- ── Global config ──────────────────────────────────────────────────
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          include_surrounding_whitespace = false,
          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"]    = "V",
            ["@block.outer"]    = "V",
          },
        },
        move = {
          set_jumps = true,
        },
      })

      -- ── Select keymaps ─────────────────────────────────────────────────
      local function sel(lhs, query, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = desc })
      end

      sel("af", "@function.outer",    "around function")
      sel("if", "@function.inner",    "inside function")
      sel("ac", "@class.outer",       "around class")
      sel("ic", "@class.inner",       "inside class")
      sel("aa", "@parameter.outer",   "around argument")
      sel("ia", "@parameter.inner",   "inside argument")
      sel("ab", "@block.outer",       "around block")
      sel("ib", "@block.inner",       "inside block")
      sel("al", "@loop.outer",        "around loop")
      sel("il", "@loop.inner",        "inside loop")
      sel("ai", "@conditional.outer", "around conditional")
      sel("ii", "@conditional.inner", "inside conditional")

      -- ── Move keymaps ───────────────────────────────────────────────────
      local function mv(lhs, fn, query, desc)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          fn(query, "textobjects")
        end, { desc = desc })
      end

      mv("]f",  move.goto_next_start,     "@function.outer",    "Next function start")
      mv("]F",  move.goto_next_end,       "@function.outer",    "Next function end")
      mv("[f",  move.goto_previous_start, "@function.outer",    "Prev function start")
      mv("[F",  move.goto_previous_end,   "@function.outer",    "Prev function end")

      mv("]c",  move.goto_next_start,     "@class.outer",       "Next class start")
      mv("]C",  move.goto_next_end,       "@class.outer",       "Next class end")
      mv("[c",  move.goto_previous_start, "@class.outer",       "Prev class start")
      mv("[C",  move.goto_previous_end,   "@class.outer",       "Prev class end")

      mv("]a",  move.goto_next_start,     "@parameter.inner",   "Next argument")
      mv("[a",  move.goto_previous_start, "@parameter.inner",   "Prev argument")

      mv("]i",  move.goto_next_start,     "@conditional.outer", "Next conditional")
      mv("[i",  move.goto_previous_start, "@conditional.outer", "Prev conditional")

      mv("]l",  move.goto_next_start,     "@loop.outer",        "Next loop")
      mv("[l",  move.goto_previous_start, "@loop.outer",        "Prev loop")

      -- ── Swap keymaps ───────────────────────────────────────────────────
      vim.keymap.set("n", "<leader>sn", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap with next argument" })

      vim.keymap.set("n", "<leader>sp", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap with prev argument" })

      -- ── Repeatable ; and , ─────────────────────────────────────────────
      local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next,     { desc = "Repeat move (forward)" })
      vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_previous, { desc = "Repeat move (backward)" })

      -- Keep f/F/t/T repeatable with ; and , too
      vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
