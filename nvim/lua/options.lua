vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showbreak = "↪"

vim.opt.showtabline = 2

vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.mousemoveevent = true

vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.g.mapleader = ","

vim.diagnostic.config({
  virtual_lines = true,
})
