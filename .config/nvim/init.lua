require("plugins") -- ./lua/plugins
-- list of vim options: https://neovim.io/doc/user/quickref.html#option-list

-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Color scheme
vim.cmd("colorscheme catppuccin")

-- Line numbers
vim.opt.nu = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Clipboard integration
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Intelligently ignore case when searching, search as you type
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clear after searching
-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Smoother navigation
vim.opt.signcolumn = "yes"
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Easier navigation between Vim splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Shortcuts when writing
vim.keymap.set('i', '<C-d>', '<C-r>=strftime("%F")<CR>') -- print current date in insert mode

-- Optimize netrw file explorer
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0 -- Open new buffers in existing window
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>')

-- fzf set up
-- Full list of commands at: https://github.com/ibhagwan/fzf-lua#usage
vim.keymap.set('n', '<leader>b', require('fzf-lua').buffers, {desc = 'fzf Buffers'})
vim.keymap.set('n', '<leader>p', require('fzf-lua').files, {desc = 'fzf Files'})
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').oldfiles, {desc = 'fzf Buffers'})
