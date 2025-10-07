vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Force Quit" })
vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { desc = "Write" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

--- lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("n", "<leader>sr", vim.lsp.buf.references, { desc = "Show References" })
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
