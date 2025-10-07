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
  -- {
  --   "sidekick.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     {
  --       "<tab>",
  --       function()
  --         -- if there is a next edit, jump to it, otherwise apply it if any
  --         if not require("sidekick").nes_jump_or_apply() then
  --           return "<Tab>" -- fallback to normal tab
  --         end
  --       end,
  --       expr = true,
  --       desc = "Goto/Apply Next Edit Suggestion",
  --     },
  --     {
  --       "<leader>aa",
  --       function() require("sidekick.cli").toggle() end,
  --       desc = "Sidekick Toggle CLI",
  --     },
  --     {
  --       "<leader>as",
  --       function() require("sidekick.cli").select() end,
  --       -- Or to select only installed tools:
  --       -- require("sidekick.cli").select({ filter = { installed = true } })
  --       desc = "Select CLI",
  --     },
  --     {
  --       "<leader>at",
  --       function() require("sidekick.cli").send({ msg = "{this}" }) end,
  --       mode = { "x", "n" },
  --       desc = "Send This",
  --     },
  --     {
  --       "<leader>av",
  --       function() require("sidekick.cli").send({ msg = "{selection}" }) end,
  --       mode = { "x" },
  --       desc = "Send Visual Selection",
  --     },
  --     {
  --       "<leader>ap",
  --       function() require("sidekick.cli").prompt() end,
  --       mode = { "n", "x" },
  --       desc = "Sidekick Select Prompt",
  --     },
  --     {
  --       "<c-.>",
  --       function() require("sidekick.cli").focus() end,
  --       mode = { "n", "x", "i", "t" },
  --       desc = "Sidekick Switch Focus",
  --     },
  --     -- Example of a keybinding to open Claude directly
  --     {
  --       "<leader>ac",
  --       function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
  --       desc = "Sidekick Toggle Claude",
  --     },
  --   },
  --   after = function()
  --     require("sidekick").setup({
  --       nes = { enabled = false },
  --       cli = {
  --         mux = {
  --           backend = "tmux",
  --           enabled = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
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
        format_on_save = {
          timeout_ms = 1500,
          lsp_format = "fallback",
        },
      })
    end,
  },
  {
    "nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_next", "fallback" },
        },
        -- completion = {
        --   documentation = { auto_show = true },
        -- },
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
        fuzzy = {
          implementation = "prefer_rust_with_warning",
          prebuilt_binaries = {
            download = true,
            -- ignore_version_mismatch = true,
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
            "diagnostics",
          },
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
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    after = function()
      require("ibl").setup()
    end,
  },
  {
    "nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "FzfLua oldfiles" },
      { "<leader>fw", "<cmd>FzfLua live_grep<cr>", desc = "FzfLua live grep" },
      { "<leader>fz", "<cmd>FzfLua zoxide<cr>", desc = "FzfLua zoxide" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "FzfLua buffers" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "FzfLua helptags" },
    },
    beforeAll = function()
      vim.g.loaded_fzf = 1
    end,
    after = function()
      require("fzf-lua").setup({
        -- { "skim" },
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
