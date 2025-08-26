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
    "volt",
  },
  {
    "menu",
    keys = {
      {
        "<C-t>",
        function()
          require("menu.utils").delete_old_menus()
          require("menu").open("default")
        end,
      },
      {
        mode = { "n", "v" },
        "<RightMouse>",
        function()
          require("menu.utils").delete_old_menus()
          require("menu").open("default", { mouse = true })
        end,
      },
    },
    beforeAll = function()
      vim.cmd("aunmenu PopUp")
    end,
  },
  {
    "minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    after = function()
      require("colorizer").setup({
        user_default_options = {
          names = false,
          -- mode = "virtualtext",
          virtualtext_inline = true,
        },
      })
    end,
  },
  -- {
  --   "tabby.nvim",
  --   event = "UIEnter",
  --   after = function()
  --     require("tabby").setup()
  --   end,
  -- },
  {
    "bufferline.nvim",
    event = "UIEnter",
    after = function()
      if vim.g.colors_name:find("catppuccin") then
        require("bufferline").setup({
          highlights = require("catppuccin.groups.integrations.bufferline").get_theme({
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
    event = "UIEnter",
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
            "diff",
            "diagnostics",
          },
        },
      })
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("which-key").setup({
        preset = "helix",
        icons = {
          keys = {
            C = "^",
          },
        },
      })
    end,
  },
  -- {
  --   "netrw.nvim",
  --   event = "DeferredUIEnter",
  --   keys = {
  --     { "<leader>e", "<cmd>Lexplore<cr>", desc = "Open netrw in working directory" },
  --   },
  --   after = function()
  --     require("netrw").setup({
  --       icons = {
  --         directory = "",
  --       },
  --     })
  --     vim.g.netrw_banner = 0
  --     vim.g.netrw_winsize = 25
  --     -- vim.g.netrw_liststyle = 3 --- refresh bug v171
  --   end,
  -- },
  {
    "yazi.nvim",
    event = "DeferredUIEnter",
    keys = {
      { "<leader>ef", "<cmd>Yazi<cr>", desc = "Open yazi in current file" },
      { "<leader>ed", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
      { "<c-n>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
    beforeAll = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    after = function()
      require("yazi").setup({
        open_for_directories = true,
      })
    end,
  },
  {
    "fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "FzfLua files" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "FzfLua buffers" },
      { "<leader>fw", "<cmd>FzfLua live_grep<cr>", desc = "FzfLua live grep" },
      { "<leader>fz", "<cmd>FzfLua zoxide<cr>", desc = "FzfLua zoxide" },
    },
    beforeAll = function()
      vim.g.loaded_fzf = 1
    end,
    after = function()
      require("fzf-lua").setup({
        -- {"skim"}
      })
    end,
  },
  {
    "indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    after = function()
      require("ibl").setup()
    end,
  },
  {
    "gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
    "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    after = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- "c", "lua", "vim", "vimdoc", "query", "markdown", --- Termux
          "markdown_inline",
          "norg",
          "csv",
          "html",
          "css",
          "xml",
          "json",
          "jsonc",
          "yaml",
          "toml",
          "bash",
          "teal",
        },
        sync_install = false,
        auto_install = true,
        -- stylua: ignore
        ignore_install = {
          "c", "lua", "vim", "vimdoc", "query", "markdown", --- Termux
          "tmux",
        },
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
    "nvim-surround",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-surround").setup()
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
    "blink.cmp",
    event = "InsertEnter",
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_next", "fallback" },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          per_filetype = {
            lua = { "lazydev", inherit_defaults = true },
          },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        fuzzy = {
          implementation = "rust",
          prebuilt_binaries = {
            download = true,
            -- ignore_version_mismatch = true,
          },
        },
      })
    end,
  },
  {
    "nvim-lspconfig",
    after = function()
      local servers = {
        clangd = {},
        rust_analyzer = {},
        kotlin_lsp = {},
        elixirls = {},
        lua_ls = {},
        teal_ls = {},
        denols = {},
        ty = {},
        phpactor = {},
        -- bashls = {},
        -- html = {},
        -- cssls = {},
        tailwindcss = {},
        taplo = {},
      }
      for server, settings in pairs(servers) do
        -- settings.capabilities = require("blink.cmp").get_lsp_capabilities(settings.capabilities)
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
      vim.keymap.set("n", "<leader>sr", vim.lsp.buf.references, { desc = "Show References" })
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
    end,
  },
  {
    "lazydev.nvim",
    ft = "lua",
    after = function()
      require("lazydev").setup({
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          -- { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "toml-edit-lua-ls-addon/library" },
          { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
          { path = "love2d/library" },
          { path = "wezterm-types", mods = { "wezterm" } },
        },
      })
    end,
  },
  {
    "trouble.nvim",
    cmd = "Trouble",
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    after = function()
      require("trouble").setup()
    end,
  },
  {
    "friendly-snippets",
  },
  {
    "conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true })
        end,
        desc = "Format buffer",
      },
    },
    after = function()
      local ft_by_formatters = {
        clang_format = { "c", "cpp" },
        rustfmt = { "rust" },
        ktlint = { "kotlin" },
        mix = { "elixir" },
        stylua = { "lua" },
        deno_fmt = { "javascript", "typescript", "markdown", "html", "css", "json", "jsonc", "yaml" },
        ruff_format = { "python" },
        php_cs_fixer = { "php" },
        -- shfmt = { "sh", "bash" },
        taplo = { "toml" },
      }
      local formatters_by_ft = {}

      for formatter, fts in pairs(ft_by_formatters) do
        for _, ft in ipairs(fts) do
          formatters_by_ft[ft] = { formatter }
        end
      end

      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        format_on_save = {
          timeout_ms = 1500,
          lsp_format = "fallback",
        },
      })
    end,
  },
  {
    "nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    after = function()
      local ft_by_linters = {
        clangtidy = { "cpp" },
        clippy = { "rust" },
        ktlint = { "kotlin" },
        credo = { "elixir" },
        luacheck = { "lua" },
        deno = { "javascript", "typescript" },
        ruff = { "python" },
        shellcheck = { "sh", "bash" },
      }
      local linters_by_ft = {}

      for linter, fts in pairs(ft_by_linters) do
        for _, ft in ipairs(fts) do
          linters_by_ft[ft] = { linter }
        end
      end

      require("lint").linters_by_ft = linters_by_ft
      require("lint").try_lint()
    end,
  },
  -- {
  --   "nvim-dap",
  --   event = "DeferredUIEnter",
  --   keys = {
  --     { "<leader>db", "<cmd>DapToggleBreakpoint<cr>" },
  --     { "<leader>dc", "<cmd>DapContinue<cr>" },
  --     { "<leader>do", "<cmd>DapStepOver<cr>" },
  --     { "<leader>di", "<cmd>DapStepInto<cr>" },
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
  --   event = "DeferredUIEnter",
  --   keys = {
  --     {
  --       "<leader>dl",
  --       function()
  --         require("osv").launch({ port = 8086 })
  --       end,
  --       desc = "Launch Lua adapter",
  --     },
  --   },
  -- },
  {
    "smart-splits.nvim",
    event = "DeferredUIEnter",
    keys = {
      { "<A-h>", "<cmd>SmartResizeLeft<cr>", desc = "Resize window left" },
      { "<A-j>", "<cmd>SmartResizeDown<cr>", desc = "Resize window down" },
      { "<A-k>", "<cmd>SmartResizeUp<cr>", desc = "Resize window up" },
      { "<A-l>", "<cmd>SmartResizeRight<cr>", desc = "Resize window right" },
      { "<A-Left>", "<cmd>SmartResizeLeft<cr>", desc = "Resize window left" },
      { "<A-Down>", "<cmd>SmartResizeDown<cr>", desc = "Resize window down" },
      { "<A-Up>", "<cmd>SmartResizeUp<cr>", desc = "Resize window up" },
      { "<A-Right>", "<cmd>SmartResizeRight<cr>", desc = "Resize window right" },
      { "<C-h>", "<cmd>SmartCursorMoveLeft<cr>", desc = "Move to left window" },
      { "<C-j>", "<cmd>SmartCursorMoveDown<cr>", desc = "Move to down window" },
      { "<C-k>", "<cmd>SmartCursorMoveUp<cr>", desc = "Move to up window" },
      { "<C-l>", "<cmd>SmartCursorMoveRight<cr>", desc = "Move to right window" },
      { "<C-Left>", "<cmd>SmartCursorMoveLeft<cr>", desc = "Move to left window" },
      { "<C-Down>", "<cmd>SmartCursorMoveDown<cr>", desc = "Move to down window" },
      { "<C-Up>", "<cmd>SmartCursorMoveUp<cr>", desc = "Move to up window" },
      { "<C-Right>", "<cmd>SmartCursorMoveRight<cr>", desc = "Move to right window" },
      { "<C-S-h>", "<cmd>SmartSwapLeft<cr>", desc = "Swap buffer left" },
      { "<C-S-j>", "<cmd>SmartSwapDown<cr>", desc = "Swap buffer down" },
      { "<C-S-k>", "<cmd>SmartSwapUp<cr>", desc = "Swap buffer up" },
      { "<C-S-l>", "<cmd>SmartSwapRight<cr>", desc = "Swap buffer right" },
      { "<C-S-Left>", "<cmd>SmartSwapLeft<cr>", desc = "Swap buffer left" },
      { "<C-S-Down>", "<cmd>SmartSwapDown<cr>", desc = "Swap buffer down" },
      { "<C-S-Up>", "<cmd>SmartSwapUp<cr>", desc = "Swap buffer up" },
      { "<C-S-Right>", "<cmd>SmartSwapRight<cr>", desc = "Swap buffer right" },
    },
    after = function()
      require("smart-splits").setup({
        -- multiplexer_integration = "tmux"
      })
    end,
  },
  {
    "hex.nvim",
    after = function()
      require("hex").setup()
    end,
  },
  {
    "translate.nvim",
    cmd = "Translate",
  },
  {
    "feed.nvim",
    cmd = "Feed",
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
  --     vim.wo.foldlevel = 99
  --     vim.wo.conceallevel = 2
  --   end,
  -- },
  {
    "vim-be-good",
    cmd = "VimBeGood",
  },
}
