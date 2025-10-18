return {
  {
    name = "Format Buffer",
    cmd = function()
      local ok, conform = pcall(require, "conform")

      if ok then
        conform.format()
      else
        vim.lsp.buf.format()
      end
    end,
    rtxt = "<leader>fm",
  },

  {
    name = "Code Actions",
    cmd = vim.lsp.buf.code_action,
    rtxt = "gra",
  },

  { name = "separator" },

  {
    name = "  Lsp Actions",
    hl = "Exblue",
    items = "lsp",
  },

  { name = "separator" },

  {
    name = "Edit Config",
    cmd = function()
      vim.cmd("tabnew")
      local conf = vim.fn.stdpath("config")
      vim.cmd("tcd " .. conf .. " | e init.lua")
    end,
    rtxt = "ed",
  },

  {
    name = "Copy Content",
    cmd = "%y+",
    rtxt = "<C-c>",
  },

  {
    name = "Delete Content",
    cmd = "%d",
    rtxt = "dc",
  },

  { name = "separator" },

  {
    name = "  Open in terminal",
    hl = "ExRed",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local old_bufname = vim.api.nvim_buf_get_name(old_buf)
      local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")
      local cmd = "cd " .. old_buf_dir

      vim.cmd("enew")
      vim.fn.jobstart({ vim.o.shell, "-c", cmd .. " ; " .. vim.o.shell }, { term = true })
    end,
  },

  { name = "separator" },

  {
    name = "  Color Picker",
    cmd = "Huefy",
  },
}
