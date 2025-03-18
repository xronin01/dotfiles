vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    vim.cmd("setlocal nonumber")
    vim.cmd("setlocal norelativenumber")
    vim.cmd("startinsert!")
  end,
})
