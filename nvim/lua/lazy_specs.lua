return {
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
          -- { path = "love2d/library" },
          { path = "wezterm-types", mods = { "wezterm" } },
        },
      })
    end,
  },
  {
    "sidekick.nvim",
    cmd = "Sidekick",
    keys = {
      { "<leader>aa", "<cmd>Sidekick cli toggle<cr>", desc = "Sidekick Toggle CLI" },
    },
    after = function()
      require("sidekick").setup({
        nes = { enabled = false },
        cli = {
          mux = { enabled = true },
        },
      })
    end,
  },
  {
    "conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format()
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
        ["tex-fmt"] = { "tex" },
        typstyle = { "typst" },
      }
      local formatters_by_ft = {}

      for formatter, fts in pairs(ft_by_formatters) do
        for _, ft in ipairs(fts) do
          formatters_by_ft[ft] = { formatter }
        end
      end

      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        default_format_opts = {
          lsp_format = "fallback",
          timeout_ms = 1500,
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 1500,
        },
      })
    end,
  },
  {
    "nvim-lint",
    event = "User FilePost",
    after = function()
      local ft_by_linters = {
        clangtidy = { "cpp" },
        clippy = { "rust" },
        ktlint = { "kotlin" },
        credo = { "elixir" },
        -- luacheck = { "lua" },
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
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "nvim-dap",
    event = "User FilePost",
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Run/Continue" },
      { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
      { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step Out" },
      { "<leader>dO", "<cmd>DapStepOver<cr>", desc = "Step Over" },
    },
    after = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }
      dap.configurations.c = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- dap.configurations.lua = {
      --   {
      --     type = "nlua",
      --     request = "attach",
      --     name = "Attach to running Neovim instance",
      --   },
      -- }
      -- dap.adapters.nlua = function(callback, config)
      --   callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      -- end
    end,
  },
  {
    "nvim-dap-view",
    cmd = {
      "DapViewOpen",
      "DapViewClose",
      "DapViewToggle",
      "DapViewWatch",
      "DapViewJump",
      "DapViewShow",
      "DapViewNavigate",
    },
    keys = {
      { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "DapView Toggle" },
    },
    before = function()
      require("lz.n").trigger_load("nvim-dap")
    end,
    after = function()
      require("dap-view").setup({
        winbar = {
          controls = {
            enabled = true,
          },
        },
      })
    end,
  },
  -- {
  --   "one-small-step-for-vimkind",
  --   event = "DeferredUIEnter",
  --   keys = {
  --     {
  --       "<leader>dl",
  --       function()
  --         require("osv").launch({ port = 8086 })
  --       end,
  --       desc = "Launch Neovim Lua adapter",
  --     },
  --   },
  -- },
  {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_next", "fallback" },
        },
        completion = {
          menu = {
            draw = {
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon" },
                { "kind" },
              },
            },
          },
        },
        sources = {
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
      })
    end,
  },
  {
    "friendly-snippets",
    event = "InsertEnter",
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
    event = "DeferredUIEnter",
    after = function()
      require("nvim-surround").setup()
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
          },
          lualine_x = { "diagnostics", "lsp_status" },
        },
      })
    end,
  },
  {
    "bufferline.nvim",
    event = "UIEnter",
    after = function()
      if (vim.g.colors_name or ""):find("catppuccin") then
        require("bufferline").setup({
          highlights = require("catppuccin.special.bufferline").get_theme({
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
    "menu",
    keys = {
      {
        "<C-t>",
        function()
          require("menu.utils").delete_old_menus()
          require("menu").open("default")
        end,
        desc = "PopupMenu",
      },
      {
        mode = { "n", "v" },
        "<RightMouse>",
        function()
          require("menu.utils").delete_old_menus()
          require("menu").open("default", { mouse = true })
        end,
        desc = "PopupMenu",
      },
    },
    beforeAll = function()
      vim.cmd.aunmenu("PopUp")
    end,
  },
  {
    "minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    cmd = "WhichKey",
    keys = {
      { "<leader>?", "<cmd>WhichKey<cr>", desc = "Whichkey all keymaps" },
    },
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
  {
    "indent-blankline.nvim",
    event = "User FilePost",
    after = function()
      require("ibl").setup()
    end,
  },
  {
    "nvim-colorizer.lua",
    event = "User FilePost",
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
  {
    "gitsigns.nvim",
    event = "User FilePost",
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
  },
  {
    "yazi.nvim",
    event = "DeferredUIEnter",
    keys = {
      { "<leader>ef", "<cmd>Yazi<cr>", desc = "Open yazi in current file" },
      { "<leader>ed", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
      { "<c-n>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
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
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "FzfLua oldfiles" },
      { "<leader>fw", "<cmd>FzfLua live_grep<cr>", desc = "FzfLua live grep" },
      { "<leader>fz", "<cmd>FzfLua zoxide<cr>", desc = "FzfLua zoxide" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "FzfLua buffers" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "FzfLua helptags" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "FzfLua keymaps" },
    },
    after = function()
      require("fzf-lua").setup({
        { "skim" },
      })
    end,
  },
  {
    "zincoxide",
    cmd = { "Z", "Zg", "Zt", "Zw" },
    after = function()
      require("zincoxide").setup({})
    end,
  },
  {
    "translate.nvim",
    cmd = "Translate",
  },
}
