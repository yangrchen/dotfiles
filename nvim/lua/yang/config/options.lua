vim.g.mapleader = " "
vim.opt.number = true

vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.python_indent = {
	open_paren = "shiftwidth()",
	closed_paren_align_last_line = false,
}

vim.opt.clipboard = "unnamedplus"

-- Set the local shiftwidth to 2 for Lua files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})
