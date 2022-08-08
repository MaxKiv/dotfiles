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
    if(lsp ~= "clangd") then 
      require('lspconfig')[lsp].setup({
        -- cmd = {lsp, "--log=verbose"},
        log = 'verbose',
        on_attach = on_attach,
        flags = lsp_flags,
      })
    else
      require('lspconfig').clangd.setup({
        cmd = {
          'clangd',
          '--log=verbose',
        }
      })
    end
  end

  -- full lsp logs
  vim.lsp.set_log_level("trace")

end

return M
