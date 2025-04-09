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
  -- {
  --   "which-key.nvim",
  --   after = function()
  --     require("which-key").setup()
  --   end,
  -- },
  -- {
  --   "tabby.nvim",
  --   after = function()
  --     require("tabby").setup()
  --   end,
  -- },
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
          -- mode = "tabs",
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
        sections = {
          lualine_b = {
            {
              "branch",
              icon = "",
            },
            "diff", "diagnostics",
          },
        },
      })
    end,
  },
  -- {
  --   "netrw.nvim",
  --   after = function()
  --     require("netrw").setup({
  --       icons = {
  --         directory = "",
  --       },
  --     })
  --     vim.g.netrw_banner = 0
  --     vim.g.netrw_winsize = 25
  --     -- vim.g.netrw_liststyle = 3 --- refresh bug v171
  --     vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<cr>")
  --   end,
  -- },
  {
    "yazi.nvim",
    beforeAll = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    after = function()
      require("yazi").setup({
        open_for_directories = true,
      })
      vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>")
    end,
  },
  {
    "fzf-lua",
    beforeAll = function()
      vim.g.loaded_fzf = 1
    end,
    after = function()
      require("fzf-lua").setup({
        -- {"skim"}
      })
      vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>")
      vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>")

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
  -- {
  --   "nvim-dap",
  --   keys = {
  --     {
  --       "<leader>db", function()
  --         require("dap").toggle_breakpoint()
  --       end,
  --     },
  --     {
  --       "<leader>dc", function()
  --         require("dap").continue()
  --       end,
  --     },
  --     {
  --       "<leader>do", function()
  --         require("dap").step_over()
  --       end,
  --     },
  --     {
  --       "<leader>di", function()
  --         require("dap").step_into()
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
  --       "<leader>dl", function()
  --         require("osv").launch({ port = 8086 })
  --       end,
  --     },
  --   },
  --   before = function()
  --     require("lz.n").trigger_load("nvim-dap")
  --   end,
  -- },
  {
    "smart-splits.nvim",
    after = function()
      require("smart-splits").setup({
        -- multiplexer_integration = "tmux"
      })
      --- Resizing splits
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
      vim.keymap.set("n", "<A-Left>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-Down>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-Up>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-Right>", require("smart-splits").resize_right)
      --- Moving between splits
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      vim.keymap.set("n", "<C-Left>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-Down>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-Up>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-Right>", require("smart-splits").move_cursor_right)
      vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
      --- Swapping buffers between windows
      vim.keymap.set("n", "<C-S-h>", require("smart-splits").swap_buf_left)
      vim.keymap.set("n", "<C-S-j>", require("smart-splits").swap_buf_down)
      vim.keymap.set("n", "<C-S-k>", require("smart-splits").swap_buf_up)
      vim.keymap.set("n", "<C-S-l>", require("smart-splits").swap_buf_right)
      vim.keymap.set("n", "<C-S-Left>", require("smart-splits").swap_buf_left)
      vim.keymap.set("n", "<C-S-Down>", require("smart-splits").swap_buf_down)
      vim.keymap.set("n", "<C-S-Up>", require("smart-splits").swap_buf_up)
      vim.keymap.set("n", "<C-S-Right>", require("smart-splits").swap_buf_right)
    end,
  },
  {
    "translate.nvim",
    after = function()
      require("translate").setup({})
    end,
  },
  {
    "feed.nvim",
    after = function()
      require("feed").setup({
        feeds = {
          "https://joshblais.com/index.xml",
        },
      })
    end,
  },
  -- {
  --   "neorg",
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
    "vim-be-good",
    cmd = "VimBeGood",
  },
}
