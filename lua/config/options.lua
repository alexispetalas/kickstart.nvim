vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.conceallevel = 1

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- Indentation settings
vim.o.tabstop = 4 -- Number of spaces a tab counts for
vim.o.shiftwidth = 4 -- Number of spaces for each indentation
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true -- Smart indenting
