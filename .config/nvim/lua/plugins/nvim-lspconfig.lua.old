-- Name of the file that (partially) overwrites default lspconfig
local lspconfig_filename = 'nvim_lspconfig.lua'

-- Default list of language servers and their options, optionally overwritten
-- by a file with the above name in the cwd
---@class lspconfig_t
local lspconfig = {
  -- Key is the LSP name as listed in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  -- NOTE: Rust is setup by rustaceanvim
  nil_ls = {
    binary = 'nil',
    settings = {
      ['nil'] = {
        formatting = {
          command = { 'alejandra', '--' },
        },
      },
    },
  },
  clangd = {
    binary = 'clangd',
    cmd = {
      'clangd',
      -- '--query-driver=*iccarm.exe',
      '--background-index',
      '--clang-tidy',
      '--enable-config',
      '-j=4', -- 4 cores
      '--pch-storage=memory',
      '--inlay-hints=true',
    },
    root_dir = {
      '.git',
    },
  },
  basedpyright = {
    binary = 'basedpyright',
    root_dir = {
      'pyrightconfig.json',
      'pyproject.toml',
      '.git',
    },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          inlayHints = {
            genericTypes = true,
          },
        },
      },
    },
  },
  lua_ls = {
    binary = 'lua-language-server',
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        diagnostics = {
          globals = { 'vim', 'LSP_SERVERS', 'to_string' },
        },
        hint = {
          enable = true,
        },
      },
    },
    root_dir = {
      '.config/nvim',
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
    },
  },
  neocmakelsp = {
    binary = 'neocmakelsp',
    setup_name = 'neocmake',
  },
  bashls = {
    binary = 'bash-language-server',
  },
  dockerls = {
    binary = 'dockerfile-language-server',
  },
  gopls = {
    binary = 'gopls',
  },
  marksman = {
    binary = 'marksman',
  },
  -- harper_ls = {
  --   linters = {
  --     LongSentences = false,
  --     SentenceCapitalization = false,
  --     SpellCheck = false,
  --   },
  -- },
}

-- Build up a local lspconfig list from cwd -> home
--- @param lspconfig lspconfig_t
--- @param dir_list List List of dirs to find nvim_lspconfig.lua in
--- @return lspconfig_t[]
local function build_project_local_lspconfig(lspconfig, dir_list)
  for _, dir in ipairs(dir_list) do
    local success, local_lspconfig = pcall(dofile, dir .. lspconfig_filename)
    if success then
      for key, value in pairs(local_lspconfig) do
        lspconfig[key] = value
      end
    end
  end

  return lspconfig
end

--- Returns a list of dirs from HOME up to dir
--- @param dir string directory to end at
local function list_dirs_to_cwd(dir)
  local home = os.getenv('HOME') or os.getenv('HOMEPATH') .. '/'
  local newdir = string.gsub(dir, home, '') or ''
  local out = {}
  table.insert(out, home)
  for w in string.gmatch(newdir, '.-%/') do
    home = home .. w
    table.insert(out, home)
  end
  return out
end

--- @param lsp_config lspconfig_t
--- @return lspconfig_t
local function project_local_overwrite_lsp_servers(lsp_config)
  ---@type lspconfig_t[]
  local local_lspconfig = {}
  local dir_list = list_dirs_to_cwd(vim.fn.fnamemodify(vim.fn.getcwd(), ':p'))
  local lspconfig_list =
    build_project_local_lspconfig(local_lspconfig, dir_list)

  for key, value in pairs(lspconfig_list) do
    lspconfig[key] = value
  end

  return lsp_config
end

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/cmp-nvim-lsp',
      {
        -- Automatically configures lua-language-server for your Neovim config,
        -- Neovim runtime and plugin directories
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup({
            library = { plugins = { 'nvim-dap-ui' }, types = true },
          })
        end,
      },
    },
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = '●' },
        severity_sort = true,
      },
      -- List of LSP servers you want installed and configured
      -- looks for nvim_lspconfig.lua files from HOME to cwd
      servers = project_local_overwrite_lsp_servers(lspconfig),
    },
    config = function(_, opts)
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
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      -- Get cmp capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
      local lspconfig = require('lspconfig')

      for lsp, options in pairs(opts.servers) do
        -- LSP setup defaults
        options.setup_name = options.setup_name or lsp
        options.root_dir = options.root_dir or { '.git' }
        -- Setup each LSP
        lspconfig[options.setup_name].setup({
          settings = options.settings,
          on_attach = on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
          cmd = options.cmd,
          root_dir = lspconfig.util.root_pattern(
            table.unpack(options.root_dir)
          ),
        })
      end

      -- full lsp logs
      vim.lsp.log.set_level('WARN')

      -- Set lsp gutter symbols
      local signs = {
        Error = '❗',
        Warn = ' ',
        Hint = 'ℹ️',
        Info = '❓',
      }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    -- Make sure all required LSP servers are installed
    config = function(_, opts)
      require('mason').setup(opts)

      -- Install LSP for all OS except Nixos
      if not require('functions').running_nixos() then
        print('not on nixos')
        local mr = require('mason-registry')
        for _, options in pairs(lspconfig) do
          local p = mr.get_package(options.binary)
          if not p:is_installed() then
            p:install()
          end
        end
      end
    end,
  },
}
