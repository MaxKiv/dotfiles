local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ 'v', 'n' }, '<leader>la', function()
  vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

vim.keymap.set({ 'v', 'n' }, '<leader>da', function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr })

vim.keymap.set({ 'v', 'n' }, '<leader>da', function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr })

vim.keymap.set({ 'v', 'n' }, '<leader>lc', function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr })

vim.keymap.set({ 'v', 'n' }, '<leader>lu', function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr })
