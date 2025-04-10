vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set

-- Easier split movement.
keymap("n", "<leader>sj", "<C-w>s", {})
keymap("n", "<leader>sl", "<C-w>v", {})
--keymap("n", "<C-j>", "<C-w>j", {})
--keymap("n", "<C-k>", "<C-w>k", {})
--keymap("n", "<C-l>", "<C-w>l", {})
--keymap("n", "<C-h>", "<C-w>h", {})
-- Centered jumps.
keymap("n", "<C-u>", "<C-u>zz", {})
keymap("n", "<C-d>", "<C-d>zz", {})
keymap("n", "O", "zzO", {})
keymap("n", "o", "zzo", {})
-- Diagnostic keymaps.
keymap("n", "[d", vim.diagnostic.goto_prev, {})
keymap("n", "]d", vim.diagnostic.goto_next, {})
keymap("n", "<leader>e", vim.diagnostic.open_float, {})
keymap("n", "<leader>q", vim.diagnostic.setloclist, {})

-- Terminal related keymaps.
-- Open terminal at the bottom of the screen with a fixed height.
keymap("n", "<leader>st", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

-- Exit terminal mode.
keymap("t", "<leader>xt", "<C-\\><C-n>")
