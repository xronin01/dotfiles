return {
  {
    "catppuccin",
    priority = 1000,
    -- colorscheme = "catppuccin",
    after = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "nvim-web-devicons",
  },
  {
    "bufferline.nvim",
    after = function()
      if vim.g.colors_name:find("catppuccin") then
        require("bufferline").setup({
          highlights = require("catppuccin.groups.integrations.bufferline").get({
            styles = {
              "no_italic",
              "bold",
            },
          }),
        })
      end
      require("bufferline").setup({
        options = {
          hover = {
            enabled = true,
            delay = 50,
            reveal = { "close" },
          },
        },
      })
    end,
  },
  {
    "lualine.nvim",
    after = function()
      require("lualine").setup({
        options = {
          component_separators = {
            left = "|",
            right = "|",
          },
          section_separators = {
            left = "",
            right = "",
          },
        },
      })
    end,
  },
  {
    "netrw.nvim",
    after = function()
      require("netrw").setup({
        icons = {
          directory = "",
        },
      })
    end,
  },
  {
    "yazi.nvim",
    -- beforeAll = function()
    --   vim.g.loaded_netrwPlugin = 1
    -- end,
    after = function()
      require("yazi").setup({
        -- open_for_directories = true,
      })
    end,
  },
  {
    "fzf-lua",
    keys = {
      {
        "<leader>f", function()
          require("fzf-lua").files()
        end,
      },
    },
    after = function()
      require("fzf-lua").setup({
        -- {"skim"}
      })
    end,
  },
  {
    "indent-blankline.nvim",
    after = function()
      require("ibl").setup()
    end,
  },
  {
    "gitsigns.nvim",
    after = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
        },
        signs_staged = {
          add = { text = "+" },
        },
      })
    end,
  },
  {
    "nvim-colorizer.lua",
    after = function()
      require("colorizer").setup()
    end,
  },
  {
    "nvim-treesitter",
    after = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ignore_install = { "tmux" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-autopairs",
    event = "InsertEnter",
    after = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "nvim-surround",
    after = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "blink.cmp",
    event = "InsertEnter",
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        appearance = {
          nerd_font_variant = "normal"
        },
        sources = {
          default = { "lsp", "buffer", "snippets", "path" },
          per_filetype = {
            lua = { "lazydev", "lsp", "buffer", "snippets", "path" },
          },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            }
          }
        },
        fuzzy = {
          implementation = "rust",
          prebuilt_binaries = {
            download = true,
            -- ignore_version_mismatch = true,
          }
        },
      })
    end,
  },
  {
    "nvim-lspconfig",
    -- lazy = true,
    before = function()
      require("lz.n").trigger_load("blink.cmp")
    end,
    after = function()
      local servers = {
        asm_lsp = {},
        clangd = {},
        rust_analyzer = {},
        gopls = {},
        leanls = {},
        kotlin_language_server = {},
        elixirls = {},
        phpactor = {},
        denols = {},
        ruff = {},
        lua_ls = {},
        bashls = {},
        awk_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        jqls = {},
        yamlls = {},
        taplo = {}
      }
      for server, config in pairs(servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        require("lspconfig")[server].setup(config)
      end
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "lazydev.nvim",
    ft = "lua",
    before = function()
      require("lz.n").trigger_load("nvim-lspconfig")
    end,
    after = function()
      require("lazydev").setup({
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "toml-edit-lua-ls-addon/library" },
          { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
          { path = "love2d/library" },
          { path = "wezterm-types", mods = { "wezterm" } },
        },
      })
    end,
  },
  {
    "friendly-snippets",
  },
  {
    "markview.nvim",
    after = function()
      require("markview").setup()
    end,
  },
  {
    "helpview.nvim",
    after = function()
      require("helpview").setup()
    end,
  },
  -- {
  --   "nvim-dap",
  --   keys = {
  --     {
  --       "<leader>dp",
  --       function()
  --         require("dap").toggle_breakpoint()
  --       end,
  --     },
  --     {
  --       "<leader>dc",
  --       function()
  --         require("dap").continue()
  --       end,
  --     },
  --   },
  --   after = function()
  --     local dap = require("dap")
  --     dap.configurations.lua = {
  --       {
  --         type = "nlua",
  --         request = "attach",
  --         name = "Attach to running Neovim instance",
  --       },
  --     }
  --     dap.adapters.nlua = function(callback, config)
  --       callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  --     end
  --   end,
  -- },
  -- {
  --   "one-small-step-for-vimkind",
  --   keys = {
  --     {
  --       "<leader>dl",
  --       function()
  --         require("osv").launch({ port = 8086 })
  --       end,
  --     },
  --   },
  --   before = function()
  --     require("lz.n").trigger_load("nvim-dap")
  --   end,
  -- },
  -- {
  --   "neorg",
  --   lazy = false,
  --   after = function()
  --     require("neorg").setup({
  --       load = {
  --         ["core.defaults"] = {},
  --         ["core.concealer"] = {},
  --         ["core.dirman"] = {
  --           config = {
  --             workspaces = {
  --               notes = "~/notes",
  --             },
  --             default_workspace = "notes",
  --           },
  --         },
  --       },
  --     })
  --
  --     vim.wo.foldlevel = 99
  --     vim.wo.conceallevel = 2
  --   end,
  -- },
  {
    "smart-splits.nvim",
    keys = {
      --- Resizing splits
      {
        "<A-h>", function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<A-j>", function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<A-k>", function()
          require("smart-splits").resize_up()
        end,
      },
      {
        "<A-l>", function()
          require("smart-splits").resize_right()
        end,
      },
      {
        "<A-Left>", function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<A-Down>", function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<A-Up>", function()
          require("smart-splits").resize_up()
        end,
      },
      {
        "<A-Right>", function()
          require("smart-splits").resize_right()
        end,
      },

      --- Moving between splits
      {
        "<C-h>", function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-j>", function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-k>", function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-l>", function()
          require("smart-splits").move_cursor_right()
        end,
      },
      {
        "<C-Left>", function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-Down>", function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-Up>", function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-Right>", function()
          require("smart-splits").move_cursor_right()
        end,
      },
      {
        "<C-\\>", function()
          require("smart-splits").move_cursor_previous()
        end,
      },

      --- Swapping buffers between windows
      {
        "<leader><leader>h", function()
          require("smart-splits").swap_buf_left()
        end,
      },
      {
        "<leader><leader>j", function()
          require("smart-splits").swap_buf_down()
        end,
      },
      {
        "<leader><leader>k", function()
          require("smart-splits").swap_buf_up()
        end,
      },
      {
        "<leader><leader>l", function()
          require("smart-splits").swap_buf_right()
        end,
      },
      {
        "<leader><leader>Left", function()
          require("smart-splits").swap_buf_left()
        end,
      },
      {
        "<leader><leader>Down", function()
          require("smart-splits").swap_buf_down()
        end,
      },
      {
        "<leader><leader>Up", function()
          require("smart-splits").swap_buf_up()
        end,
      },
      {
        "<leader><leader>Right", function()
          require("smart-splits").swap_buf_right()
        end,
      },
    },
  },
  {
    "vim-be-good",
    cmd = "VimBeGood",
  },
}
