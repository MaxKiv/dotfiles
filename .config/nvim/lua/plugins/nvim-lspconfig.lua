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
  },
  ["robotframework_ls"] = {
    binary = "robotframework-lsp",
  },
  pyright = {
    binary = "pyright",
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
  },
  cmake = {
    binary = "cmake-language-server",
    settings = {
      CMake = {
        filetypes = {
          "cmake",
          "CmakeLists.txt",
        },
      },
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
      -- Automatically format on save
      autoformat = true,
      -- List servers you want installed
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

      for lsp, options in pairs(opts.servers) do
        require('lspconfig')[lsp].setup({
          settings = options.settings,
          on_attach = on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
        })
      end

      -- elseif (lsp == "omnisharp") then
      --   -- Omnisharp stuff
      --   local omnisharp_bin = "/home/max/.local/share/nvim/mason/bin/omnisharp"
      --   local omnisharp_pid = vim.fn.getpid()
      --   local csharp_lsp_cmd;
      --   if vim.loop.os_uname().sysname == "Windows_NT" then
      --     csharp_lsp_cmd = { "dotnet", [[C:\Users\max\AppData\Local\nvim-data\mason\packages\omnisharp\OmniSharp.dll]] };
      --   else
      --     csharp_lsp_cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(omnisharp_pid) };
      --   end
      --   require("lspconfig").omnisharp.setup({
      --     cmd = csharp_lsp_cmd,
      --     enable_roselyn_analyzers = true,
      --     organize_imports_on_format = true,
      --     root_pattern = { "*.sln" },
      --     on_attach = on_attach,
      --     flags = lsp_flags,
      --     capabilities = capabilities,
      --   })
      -- elseif (lsp == "lemminx") then

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
