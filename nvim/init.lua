--- Bootstrap paq-nvim
local paq_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if not vim.uv.fs_stat(paq_path) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "https://github.com/savq/paq-nvim",
    paq_path,
  })
  vim.cmd.packadd("paq-nvim")
end

require("options")
require("keymaps")
require("autocmd")

require("paq")({
  { "savq/paq-nvim" },
  { "lumen-oss/lz.n" },
  { "nvim-lua/plenary.nvim" },

  { "catppuccin/nvim", opt = true, as = "catppuccin" },
  { "nvim-tree/nvim-web-devicons", opt = true },
  { "akinsho/bufferline.nvim", opt = true },
  { "nvim-lualine/lualine.nvim", opt = true },
  { "nvzone/volt", opt = true },
  { "nvzone/menu", opt = true },
  { "nvzone/minty", opt = true },
  { "folke/which-key.nvim", opt = true },
  { "nvim-treesitter/nvim-treesitter", opt = true, branch = "main", build = ":TSUpdate" },
  { "lukas-reineke/indent-blankline.nvim", opt = true },
  { "catgoose/nvim-colorizer.lua", opt = true },
  { "lewis6991/gitsigns.nvim", opt = true },
  { "kylechui/nvim-surround", opt = true },
  { "windwp/nvim-autopairs", opt = true },
  { "Saghen/blink.cmp", opt = true, branch = "v1.7.0" },
  { "rafamadriz/friendly-snippets", opt = true },
  { "neovim/nvim-lspconfig", opt = true },
  { "folke/lazydev.nvim", opt = true },
  { "folke/trouble.nvim", opt = true },
  { "stevearc/conform.nvim", opt = true },
  { "mfussenegger/nvim-lint", opt = true },
  { "mfussenegger/nvim-dap", opt = true },
  { "jbyuki/one-small-step-for-vimkind", opt = true },
  { "mason-org/mason.nvim", opt = true },
  { "nvim-neotest/neotest", opt = true },
  { "mrjones2014/smart-splits.nvim", opt = true },
  { "mikavilpas/yazi.nvim", opt = true },
  { "ibhagwan/fzf-lua", opt = true },
  { "thunder-coding/zincoxide", opt = true },
  { "DAmesberger/sc-im.nvim", opt = true },
  { "uga-rosa/translate.nvim", opt = true },
  { "RaafatTurki/hex.nvim", opt = true },
  --- Luals addons
  { "Bilal2453/luvit-meta", opt = true },
  { "lumen-oss/toml-edit-lua-ls-addon", opt = true },
  { "xmake-io/xmake-luals-addon", opt = true },
  { "LuaCATS/love2d", opt = true },
  { "DrKJeff16/wezterm-types", opt = true },
})
require("paq").install()

local ok, lz = pcall(require, "lz.n")
if ok then
  lz.load("plugins")
end
