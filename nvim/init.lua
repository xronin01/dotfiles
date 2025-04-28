--- Bootstrap paq-nvim
local paq_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if not vim.uv.fs_stat(paq_path) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "https://github.com/savq/paq-nvim.git",
    paq_path,
  })
end
-- vim.opt.rtp:prepend(paq_path)
vim.cmd.packadd("paq-nvim")

require("options")
require("keymaps")
require("autocmd")

require("paq")({
  { "savq/paq-nvim" },
  { "nvim-neorocks/lz.n" },

  { "catppuccin/nvim", opt = true, as = "catppuccin" },
  { "nvim-tree/nvim-web-devicons", opt = true },
  { "folke/which-key.nvim", opt = true },
  { "akinsho/bufferline.nvim", opt = true },
  { "nanozuki/tabby.nvim", opt = true },
  { "nvim-lualine/lualine.nvim", opt = true },
  { "prichrd/netrw.nvim", opt = true },
  { "mikavilpas/yazi.nvim", opt = true },
  { "ibhagwan/fzf-lua", opt = true },
  { "lukas-reineke/indent-blankline.nvim", opt = true },
  { "lewis6991/gitsigns.nvim", opt = true },
  { "catgoose/nvim-colorizer.lua", opt = true },
  { "nvim-treesitter/nvim-treesitter", opt = true, build = ":TSUpdate" },
  { "kylechui/nvim-surround", opt = true },
  { "windwp/nvim-autopairs", opt = true },
  { "Saghen/blink.cmp", opt = true, branch = "v1.1.1" },
  { "neovim/nvim-lspconfig", opt = true },
  { "folke/lazydev.nvim", opt = true },
  { "folke/trouble.nvim", opt = true },
  { "rafamadriz/friendly-snippets", opt = true },
  { "stevearc/conform.nvim", opt = true },
  { "mfussenegger/nvim-lint", opt = true },
  { "mfussenegger/nvim-dap", opt = true },
  { "jbyuki/one-small-step-for-vimkind", opt = true },
  { "mrjones2014/smart-splits.nvim", opt = true },
  { "uga-rosa/translate.nvim", opt = true },
  { "neo451/feed.nvim", opt = true },
  { "nvim-neorg/neorg", opt = true },
  { "ThePrimeagen/vim-be-good", opt = true },
  --- Luals addons
  { "Bilal2453/luvit-meta", opt = true },
  { "nvim-neorocks/toml-edit-lua-ls-addon", opt = true },
  { "xmake-io/xmake-luals-addon", opt = true },
  { "LuaCATS/love2d", opt = true },
  { "gonstoll/wezterm-types", opt = true },
  --- Libs
  { "gregorias/coop.nvim" }, --- dep of feed.nvim
  { "nvim-lua/plenary.nvim" }, --- dep of yazi.nvim and neorg
  { "pysan3/pathlib.nvim" }, --- dep of neorg
  { "MunifTanjim/nui.nvim" }, --- dep of neorg
  { "nvim-neotest/nvim-nio" }, --- dep of neorg
  { "nvim-neorg/lua-utils.nvim" }, --- dep of neorg
})

local ok, lz = pcall(require, "lz.n")
if ok then
  lz.load("plugins")
end
