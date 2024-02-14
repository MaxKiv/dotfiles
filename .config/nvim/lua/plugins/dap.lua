local dap_config = {
  adapters = {

    -- lldb = {
    --   lang = 'cpp',
    --   type = 'executable',
    --   binary = 'codelldb',
    --   name = 'lldb',
    --   port = 1300,
    -- },

    debugpy = {
      lang = 'python',
      type = 'executable',
      binary = 'debugpy',
      name = 'debugpy'
    },

  },

  -- TODO add to this structure?
  -- configurations = {
  -- }

}

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function(plugin, opts)
      local dap = require('dap')
      local mason_binary_dir = vim.fn.stdpath('data') .. '/mason/bin/'
      require("mason").setup(opts)
      local mr = require("mason-registry")

      -- make sure required Debug adapters are installed and configured
      for dap_name, dap_opts in pairs(dap_config.adapters) do
        -- Install using Mason if adapter is missing
        local p = mr.get_package(dap_opts.binary)
        if not p:is_installed() then
          p:install()
        end

        -- Setup adapters
        dap.adapters[dap_opts.lang] = {
          type = 'executable',
          command = mason_binary_dir .. dap_opts.binary,
          name = dap_name,
          port = dap_opts.port
        }
      end

      dap.adapters.cpp = {
        type = 'server',
        port = '13000',
        executable = {
          command = 'codelldb',
          args = { '--port', '13000' },
        },
      }

      -- Setup configurations
      dap.configurations.python = {
        {
          name = "Launch file",
          type = 'python',
          request = 'launch',
          program = "${file}",
          pythonPath = function()
            return '/usr/bin/python'
          end,
        },
      }

      dap.configurations.cpp = {
        {
          name = "lldb: Debug executable",
          type = 'cpp',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          runInTerminal = false,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          port = 13000,
        },

        {
          name = "Clang10 + lldb",
          type = 'cpp',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to source code: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

    end
  },

  {
    -- Nice DAP ui
    "rcarriga/nvim-dap-ui",
  },
}
