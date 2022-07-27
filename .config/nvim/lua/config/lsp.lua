local M  = {}

function M.setup()

  local on_attach = function(client,bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- TODO set buffer local keymaps here 
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  for _, lsp in pairs(LSP_SERVERS) do
    require('lspconfig')[lsp].setup({
      on_attach = on_attach,
      flags = lsp_flags,
    })
  end

end

return M
