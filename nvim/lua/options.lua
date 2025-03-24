--- Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.mousemoveevent = true
-- vim.opt.wrap = true
-- vim.opt.termguicolors = true
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.swapfile = false

--- Tab Settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

--- Indentation Settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

--- Leader key
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
