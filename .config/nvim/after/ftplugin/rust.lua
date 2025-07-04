local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ 'v', 'n' }, '<leader>la', function()
  vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
  'n',
  'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)

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

vim.keymap.set(
  'n',
  ']d', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'renderDiagnostic', 'cycle' })
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  'n',
  '[d', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'renderDiagnostic', 'cycle', 'prev' })
  end,
  { silent = true, buffer = bufnr }
)

-- vim.keymap.set(
--   'n',
--   ']e', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
--   function()
--     vim.cmd.RustLsp({ 'explainError', 'cycle' })
--   end,
--   { silent = true, buffer = bufnr }
-- )
-- vim.keymap.set(
--   'n',
--   '[e', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
--   function()
--     vim.cmd.RustLsp({ 'explainError', 'cycle', 'prev' })
--   end,
--   { silent = true, buffer = bufnr }
-- )

vim.keymap.set(
  'n',
  ']r', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp('relatedDiagnostics')
  end,
  { silent = true, buffer = bufnr }
)
