return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = {
			{
				"<leader>p",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						position = "left",
					})
				end,
				desc = "Neotree: toggle file explorer",
			},
		},
	},
}
