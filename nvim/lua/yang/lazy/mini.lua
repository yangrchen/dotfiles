return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.git").setup()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.statusline").setup()
		end,
	},
}
