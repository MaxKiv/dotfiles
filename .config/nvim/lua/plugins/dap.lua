local dap_config = {
  adapters = {
    lldb = {
      type = 'executable',
      binary = 'codelldb',
      name = 'lldb'
    },
    debugpy = {
      type = 'executable',
      binary = 'debugpy',
      name = 'debugpy'
    },
  },

  configurations = {

  }

}

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function(plugin, opts)
      local mason_binary_dir = vim.fn.stdpath('data') .. '/mason/bin/'
      -- make sure required Debug adapters are installed
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for dap_name, dap_opts in pairs(dap_config.adapters) do
        local p = mr.get_package(dap_opts.binary)
        if not p:is_installed() then
          p:install()
        end
      end

      -- Setup adapters
      local dap = require('dap')

      for dap_name, dap_opts in pairs(dap_config.adapters) do
        dap.adapters[dap_name] = {
          type = 'executable',
          command = mason_binary_dir .. dap_opts.binary,
          name = dap_name,
        }
      end

      -- Setup configurations
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return '/usr/bin/python'
          end,
        },
      }

    end
  },

  {
    "rcarriga/nvim-dap-ui",

  },
}
