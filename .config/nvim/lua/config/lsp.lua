local M = {}

function M.setup()

  local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"
  local omnisharp_pid = vim.fn.getpid()

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- TODO set buffer local keymaps here
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  -- Get cmp capabilities from nvim-cmp
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, lsp in pairs(LSP_SERVERS) do
    if (lsp == "clangd") then
      require('lspconfig').clangd.setup({
        cmd = {
          'clangd',
          -- '/home/max/Downloads/esp-clang/bin/clangd', -- for ESP
          '--background-index',
          '--clang-tidy',
          '--enable-config',
          -- '--query-driver=/home/max/.espressif/tools/xtensa-esp32-elf/esp-2022r1-11.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-*',
          -- '--query-driver=',
        },
        capabilities = capabilities,
      })
    elseif (lsp == "sumneko_lua") then
      require("lspconfig").sumneko_lua.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "LSP_SERVERS", "to_string" },
            }
          }
        },
        capabilities = capabilities,
      })
    elseif (lsp == "omnisharp") then
      local csharp_lsp_cmd;
      if vim.loop.os_uname().sysname == "Windows_NT" then
        csharp_lsp_cmd = { "dotnet", [[C:\Users\max\AppData\Local\nvim-data\mason\packages\omnisharp\OmniSharp.dll]] };
      else
        csharp_lsp_cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(omnisharp_pid) };
      end
      require("lspconfig").omnisharp.setup({
        -- cmd = { "mono", "/home/max/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/Microsoft.CodeAnalysis.ExternalAccess.OmniSharp.dll"},
        -- cmd = { "dotnet", "/home/max/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/OmniSharp.Roslyn.dll", "--self-contained"},
        cmd = csharp_lsp_cmd,
        enable_roselyn_analyzers = true,
        organize_imports_on_format = true,
        root_pattern = { "*.sln" },
        capabilities = capabilities,
      })
    elseif (lsp == "lemminx") then
      require("lspconfig").lemminx.setup({
        file_types = { "xml", "xsd", "xsl", "xslt", "svg", "xaml" },
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })
    else
      require('lspconfig')[lsp].setup({
        -- cmd = {lsp, "--log=verbose"},
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })
    end
  end

  -- full lsp logs
  vim.lsp.set_log_level("WARN")

end

return M
