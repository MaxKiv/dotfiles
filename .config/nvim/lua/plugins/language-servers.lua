local language_servers = {
  ['nil_ls'] = {
    mason = 'nil',
    cmd = { 'nil' },
    filetypes = { 'nix' },
    root_markers = { '.git' },
    settings = {
      ['nil'] = {
        formatting = { command = { 'alejandra', '--' } },
      },
    },
  },
  ['clangd'] = {
    mason = 'clangd',
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--enable-config',
      '-j=4',
      '--pch-storage=memory',
      '--inlay-hints=true',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { '.clangd', 'compile_commands.json', '.git' },
  },
  ['basedpyright'] = {
    mason = 'basedpyright',
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyrightconfig.json', 'pyproject.toml', '.git' },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          inlayHints = { genericTypes = true },
        },
      },
    },
  },
  ['ruff'] = {
    mason = 'ruff',
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  },
  ['lua_ls'] = {
    mason = 'lua-language-server',
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      '.git',
    },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        diagnostics = { globals = { 'vim' } },
        hint = { enable = true },
      },
    },
  },
  ['neocmake'] = {
    mason = 'neocmakelsp',
    cmd = { 'neocmakelsp', '--stdio' },
    filetypes = { 'cmake' },
    root_markers = { 'CMakeLists.txt', '.git' },
  },
  ['bashls'] = {
    mason = 'bash-language-server',
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' },
    root_markers = { '.git' },
  },
  ['dockerls'] = {
    mason = 'dockerfile-language-server',
    cmd = { 'dockerfile-language-server', '--stdio' },
    filetypes = { 'dockerfile' },
    root_markers = { 'Dockerfile', '.git' },
  },
  ['gopls'] = {
    mason = 'gopls',
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.mod', 'go.work', '.git' },
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  ['marksman'] = {
    mason = 'marksman',
    cmd = { 'marksman', 'server' },
    filetypes = { 'markdown' },
    root_markers = { '.marksman.toml', '.git' },
  },
  -- Note: Handled by rustaceanvim
  -- ['rust_analyzer'] = {
  --   mason = 'rust-analyzer',
  --   cmd = { 'rust-analyzer' },
  --   filetypes = { 'rust' },
  --   root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
  --   settings = {
  --     ['rust-analyzer'] = {
  --       inlayHints = {
  --         bindingModeHints = { enable = true },
  --         closureReturnTypeHints = { enable = 'always' },
  --         parameterHints = { enable = true },
  --       },
  --     },
  --   },
  -- },
  ['ts_ls'] = {
    mason = 'typescript-language-server',
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  },
  ['jsonls'] = {
    mason = 'json-lsp',
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    settings = {
      json = { validate = { enable = true } },
    },
  },
  ['yamlls'] = {
    mason = 'yaml-language-server',
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_markers = { '.git' },
    settings = {
      yaml = {
        validate = true,
        schemaStore = {
          enable = true,
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
      },
    },
  },
  ['taplo'] = {
    mason = 'taplo',
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { '.git' },
  },
  ['html'] = {
    mason = 'html-lsp',
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { 'package.json', '.git' },
    settings = {
      configurationSection = { 'html', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = true,
    },
  },
  ['cssls'] = {
    mason = 'css-lsp',
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
  },
}

return {
  {
    'folke/neoconf.nvim',
    priority = 1000, -- must load before LSP
    config = function()
      require('neoconf').setup({
        -- reads .neoconf.json and .vscode/settings.json automatically
      })
    end,
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neoconf.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Global capabilities for all servers
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })

      -- Diagnostic display
      local virt_lines_ns = vim.api.nvim_create_namespace('on_diagnostic_jump')
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = { spacing = 4, prefix = '●' },
        jump = {
          on_jump = function(diagnostic, bufnr)
            if not diagnostic then
              return
            end
            vim.diagnostic.show(
              virt_lines_ns,
              bufnr,
              { diagnostic },
              { virtual_lines = { current_line = true } }
            )
          end,
        },
      })

      -- Register neoconf schema so .vscode/settings.json keys are understood
      local neoconf_defaults = {}
      for name, _ in pairs(language_servers) do
        neoconf_defaults[name] = { enable = true }
      end
      require('neoconf.plugins').register({
        name = 'lsp-settings',
        on_schema = function(schema)
          schema:import('lsp-settings', neoconf_defaults)
        end,
      })

      -- Configure and enable all servers
      for name, config in pairs(language_servers) do
        vim.lsp.config(name, config)
      end
      vim.lsp.enable(vim.tbl_keys(language_servers))

      -- Load project-local server additions/overrides from .vscode/settings.json
      local project_servers = require('neoconf').get('nvim-lsp', {})
      for name, config in pairs(project_servers) do
        vim.lsp.config(
          name,
          vim.tbl_deep_extend('force', language_servers[name] or {}, config)
        )
        vim.lsp.enable(name)
      end

      -- LspAttach: inlay hints
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end
          if client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
        end,
      })
    end,
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    -- Make sure all required LSP servers are installed
    config = function(_, opts)
      require('mason').setup(opts)
      if not require('functions').running_nixos() then
        local mr = require('mason-registry')
        for _, config in pairs(language_servers) do
          if config.mason then
            local ok, pkg = pcall(mr.get_package, config.mason)
            if ok and not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end
    end,
  },
}
