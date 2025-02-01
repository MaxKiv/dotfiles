return {
  {
    'Feel-ix-343/markdown-oxide',
    config = function(_, opts)
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Enable statusline location if this lsp supports it
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
        -- Enable inlay hints if this lsp supports it
        if client.server_capabilities.inlayHintProvider then
          vim.g.inlay_hints_visible = true
          vim.lsp.inlay_hint.enable(true)
        end

        -- setup Markdown Oxide daily note commands
        if client.name == 'markdown_oxide' then
          vim.api.nvim_create_user_command('Daily', function(args)
            local input = args.args

            vim.lsp.buf.execute_command({
              command = 'jump',
              arguments = { input },
            })
          end, { desc = 'Open daily note', nargs = '*' })
        end
      end

      -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
      -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      -- Register the markdown_oxide LSP with lspconfig
      require('lspconfig').markdown_oxide.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      local function check_codelens_support()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        for _, c in ipairs(clients) do
          if c.server_capabilities.codeLensProvider then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd(
        { 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' },
        {
          buffer = bufnr,
          callback = function()
            if check_codelens_support() then
              vim.lsp.codelens.refresh({ bufnr = 0 })
            end
          end,
        }
      )
      -- trigger codelens refresh
      vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end,
  },

  {
    -- markdown-oxide requires some
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      for _, source in ipairs(opts.sources or {}) do
        if source.name == 'nvim_lsp' then
          source.option = require('functions').extend_tbl(
            source.option,
            { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } }
          )
          break
        end
      end
    end,
  },
}
