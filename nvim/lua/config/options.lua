-- Auto formatting.
vim.g.autoformat = true
-- Supress deprecation warnings.
vim.g.deprecation_warnings = false
-- Whether a Nerd Font is installed and selected in the terminal.
vim.g.have_nerd_font = true
-- Fix markdown indentation settings.
vim.g.markdown_recommended_style = 0
-- Disable netwr.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.completeopt = "menu,menuone,noselect"
-- Enable highlighting of the current line.
opt.cursorline = true
-- Use spaces instead of tabs.
opt.expandtab = true
-- Wrap lines at convenient points.
opt.linebreak = true
-- Enable mouse mode.
opt.mouse = "a"
-- Print line number.
opt.number = true
-- Relatieve line numbers.
opt.relativenumber = true
-- Round indent.
opt.shiftround = true
-- Size of an indent.
opt.shiftwidth = 4
-- Always sho the signcolumn, otherwise it would shift the text each time.
opt.signcolumn = "yes"
-- Insert indents automatically.
opt.smartindent = true
-- Enable spell checking.
opt.spell = false
-- Spell checking will be done for the below languages.
opt.spelllang = { "en_us" }
-- Number of spaces tabs count for.
opt.tabstop = 4
-- Set light theme
opt.background = "light"
-- True color support.
opt.termguicolors = true
-- Save undo history to an undo file.
opt.undofile = true
-- Disable line wrap.
opt.wrap = false

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
