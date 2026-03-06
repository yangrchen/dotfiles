-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>sq", "<C-w>q", { desc = "Close window" })

-- Window move
vim.keymap.set("n", "<leader>rh", "<C-w>H", { desc = "Move window left" })
vim.keymap.set("n", "<leader>rj", "<C-w>J", { desc = "Move window down" })
vim.keymap.set("n", "<leader>rk", "<C-w>K", { desc = "Move window up" })
vim.keymap.set("n", "<leader>rl", "<C-w>L", { desc = "Move window right" })

-- Closing buffers
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Terminal toggle
local term_buf = nil
local term_win = nil

vim.keymap.set({ "n", "t" }, "<C-t>", function()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_hide(term_win)
		term_win = nil
	elseif term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd("split")
		vim.cmd("wincmd j")
		vim.api.nvim_win_set_buf(0, term_buf)
		term_win = vim.api.nvim_get_current_win()
		vim.cmd("startinsert")
	else
		vim.cmd("split")
		vim.cmd("wincmd j")
		vim.cmd("terminal")
		term_buf = vim.api.nvim_get_current_buf()
		term_win = vim.api.nvim_get_current_win()
		vim.cmd("startinsert")
	end
end, { desc = "Toggle terminal" })

-- Terminal mode
vim.keymap.set("n", "<leader>tv", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { desc = "Open terminal in vertical split" })
vim.keymap.set("n", "<leader>th", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { desc = "Open terminal in horizontal split" })
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
