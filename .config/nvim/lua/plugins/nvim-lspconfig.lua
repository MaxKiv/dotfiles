-- List of language servers and their options
local servers = {
  -- Key is the LSP name as listed in https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ["rust_analyzer"] = {
    -- NOTE: required Name of LSP binary
    binary = "rust-analyzer",
  },
  clangd = {
    binary = "clangd",
    cmd = {
      'clangd',
      -- '/home/max/Downloads/esp-clang/bin/clangd', -- for ESP
      -- '--query-driver=/home/max/.espressif/tools/xtensa-esp32-elf/esp-2022r1-11.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-*',
      '--query-driver=C:/Program Files (x86)/IAR Systems/Embedded Workbench 8.4 arm 8.50.9/arm/bin/iccarm.exe',
      '--background-index',
      '--clang-tidy',
      '--enable-config',
    },
    root_dir = {
      "compile_commands.json",
      ".git"
    },
  },
  ["robotframework_ls"] = {
    binary = "robotframework-lsp",
    root_dir = {
      ".git"
    },
    cmd = {
      [[C:\Users\KIM1DEV\AppData\Local\nvim-data\mason\packages\robotframework-lsp\venv\Scripts\robotframework_ls.exe]],
    },
  },
  pyright = {
    binary = "pyright",
    root_dir = {
      "pyrightconfig.json",
      "pyproject.toml",
      ".git"
    },
  },
  jsonls = {
    binary = "json-lsp",
  },
  sumneko_lua = {
    binary = "lua-language-server",
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        diagnostics = {
          globals = { "vim", "LSP_SERVERS", "to_string" },
        }
      },
    },
    root_dir = {
      ".git",
      vim.fn.expand('$HOME/.config'),
    },
  },
  neocmakelsp = {
    binary = "neocmakelsp",
    setup_name = "neocmake",
    cmd = {
      [[C:\Users\KIM1DEV\git\neocmakelsp\target\release\neocmakelsp.exe]], "--stdio",
    },
  },
  bashls = {
    binary = "bash-language-server",
  },
  dockerls = {
    binary = "dockerfile-language-server",
  },
  gopls = {
    binary = "gopls",
  },
  hls = {
    binary = "haskell-language-server",
    cmd = { "haskell-language-server-wrapper", "--lsp" },
  },
}


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- List servers you want installed and configured
      servers = servers
    },
    config = function(plugin, opts)
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      -- Get cmp capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require('lspconfig')

      for lsp, options in pairs(opts.servers) do
        -- LSP setup defaults
        options.setup_name = options.setup_name or lsp
        options.root_dir = options.root_dir or {'.git'}
        -- Setup each LSP
        lspconfig[options.setup_name].setup({
          settings = options.settings,
          on_attach = on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
          cmd = options.cmd,
          root_dir = lspconfig.util.root_pattern(table.unpack(options.root_dir))
        })
      end

      -- full lsp logs
      vim.lsp.set_log_level("WARN")

      -- Set lsp gutter symbols
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " "
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    -- Make sure all required LSP servers are installed
    config = function(plugin, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, options in pairs(servers) do
        local p = mr.get_package(options.binary)
        if not p:is_installed() then
          p:install()
        end
      end
    end
  },
}
