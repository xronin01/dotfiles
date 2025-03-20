local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- opt.wrap = false
opt.breakindent = true
opt.showbreak = "↪"

opt.showtabline = 2

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

opt.mouse = "a"
opt.mousescroll = "ver:1,hor:6"
opt.mousemoveevent = true

opt.confirm = true
opt.undofile = true
opt.swapfile = false

opt.splitright = true
opt.splitbelow = true

opt.ignorecase = true
opt.smartcase = true

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

g.mapleader = ","

--- Disable some default plugins
g.loaded_netrwPlugin = 1
g.loaded_fzf = 1

--- Disable some default providers
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

vim.diagnostic.config({
  virtual_lines = true,
})
