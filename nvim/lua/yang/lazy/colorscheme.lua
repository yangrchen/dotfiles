return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				custom_highlights = function(colors)
					return {
						MiniStatuslineModeNormal = { bg = colors.sky, fg = colors.base, style = { "bold" } },
						MiniStatuslineModeInsert = { bg = colors.mauve, fg = colors.base, style = { "bold" } },

						LineNr = { fg = colors.text },
						CursorLineNr = { fg = colors.text, style = { "bold" } },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
