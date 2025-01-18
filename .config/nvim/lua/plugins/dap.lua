local dap_config = {
  adapters = {
    codelldb = {
      binary = 'codelldb',
    },

    debugpy = {
      binary = 'debugpy',
    },
  },
}

local exe_path = nil

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",

      {
        -- Nice DAP ui
        "rcarriga/nvim-dap-ui",
        config = function(_, _)
          local dap, dapui = require("dap"), require("dapui")
          --use nvim-dap events to open and close the windows automatically
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end

          require("dapui").setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },
            mappings = {
              -- Use a table to apply multiple mappings
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
              -- Example:
              -- stacks = {
              --   open = "<CR>",
              --   expand = "o",
              -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
              {
                elements = {
                  -- Elements can be strings or table with id and size keys.
                  "watches",
                  "breakpoints",
                  "stacks",
                  "repl",
                },
                size = 50, -- 50 columns
                position = "left",
              },
              {
                elements = {
                  -- "console",
                  -- { id = "scopes", size = .75 },
                  "scopes",
                  -- {id = "repl", size = .75 },
                },
                size = .30, -- 25% of total lines
                position = "bottom",
              },
            },
            controls = {
              -- Requires Neovim nightly (or 0.8 when released)
              enabled = true,
              -- Display controls in this element
              element = "repl",
              icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
              },
            },
            floating = {
              max_height = nil,  -- These can be integers or a float between 0 and 1.
              max_width = nil,   -- Floats will be treated as percentage of your screen.
              border = "double", -- Border style. Can be "single", "double" or "rounded"
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil, -- Can be integer or nil.
              max_value_lines = 100, -- Can be integer or nil.
            }
          })
        end
      },

      {
        -- Vscode like dap project file
        "ldelossa/nvim-dap-projects",
        config = function(_, _)
          -- require('nvim-dap-projects').config_paths = {"./test/nvim-dap.lua"}
          require('nvim-dap-projects').search_project_config()
        end
      },

      {
        -- Neovim plugin for persistent breakpoints
        "Weissle/persistent-breakpoints.nvim",
        config = function(_, _)
          require('persistent-breakpoints').setup{
            save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
            -- when to load the breakpoints? "BufReadPost" is recommanded.
            load_breakpoints_event = "BufReadPost",
            -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
            perf_record = false,
            -- perform callback when loading a persisted breakpoint
            --- @param opts DAPBreakpointOptions options used to create the breakpoint ({condition, logMessage, hitCondition})
            --- @param buf_id integer the buffer the breakpoint was set on
            --- @param line integer the line the breakpoint was set on
            on_load_breakpoint = nil,
          }
        end
      },

      -- Add DAP section to whichkey
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>d"] = { desc = "+debug" },
          },
        },
      },

      {
        "nvim-neotest/nvim-nio" 
      },
    },

    cmd = {
      "DapContinue",
    },

    keys = {
      {
        "<leader>da",
        function() require("dap").continue() end,
        desc =
          "Continue"
      },
      {
        "<leader>df",
        function() require("dap").terminate() end,
        desc =
          "Terminate"
      },
      {
        "<leader>dB",
        function() require('persistent-breakpoints.api').set_conditional_breakpoint() end,
        desc =
          "Conditional Breakpoint"
      },
      {
        "<leader>db",
        function() require('persistent-breakpoints.api').toggle_breakpoint() end,
        desc =
          "Toggle Breakpoint"
      },
      {
        "<leader>dx",
        function()  require('persistent-breakpoints.api').clear_all_breakpoints() end,
        desc =
          "Clear all Breakpoints"
      },
      {
        "<leader>dL",
        function()
          require("dap").toggle_breakpoint(nil, nil,
            vim.fn.input({ prompt = 'Log point message: ' }))
        end,
        desc =
          "Toggle Logpoint"
      },
      {
        "<leader>dc",
        function() require("dap").run_to_cursor() end,
        desc =
          "Run to Cursor"
      },
      {
        "<leader>dg",
        function() require("dap").goto_() end,
        desc =
          "Go to line (no execute)"
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc =
          "Step Into"
      },
      {
        "<leader>dd",
        function() require("dap").down() end,
        desc =
          "Down"
      },
      {
        "<leader>du",
        function() require("dap").up() end,
        desc =
          "Up"
      },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc =
          "Run Last"
      },
      {
        "<leader>dk",
        function() require("dap").step_out() end,
        desc =
          "Step Out"
      },
      {
        "<leader>dj",
        function() require("dap").step_over() end,
        desc =
          "Step Over"
      },
      {
        "<leader>dp",
        function() require("dap").pause() end,
        desc =
          "Pause"
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc =
          "Toggle REPL"
      },
      {
        "<leader>dt",
        function() require("dap").restart_frame() end,
        desc =
          "Restart frame"
      },
      {
        "<leader>dw",
        function() require("dap.ui.widgets").hover() end,
        desc =
          "Widgets"
      },
      {
        "<leader>dS",
        function() require("dap.ui.widgets").centered_float(require('dap.ui.widgets').scopes) end,
        desc =
          "Scopes"
      },
      {
        "<leader>ds",
        function() require("dap.ui.widgets").centered_float(require('dap.ui.widgets').frames) end,
        desc =
          "Frames"
      },
      {
        "<leader>dt",
        function() require("dap.ui.widgets").centered_float(require('dap.ui.widgets').threads) end,
        desc =
          "Threads"
      },
      {
        "<leader>ff",
        function() require("telescope").extensions.dap.frames() end,
        desc =
          "DAP frames"
      },
      {
        "<leader>fb",
        function() require("telescope").extensions.dap.list_breakpoints() end,
        desc =
          "DAP breakpoints"
      },
      {
        "<leader>dv",
        function() require('dap.ext.vscode').load_launchjs(nil, nil) end,
        desc =
          "Load launch json in current project root"
      },
    },

    config = function(_, opts)
      local dap = require('dap')
      dap.set_log_level('info')

      -- Let overseer patch dap if its in da house
      require("overseer").patch_dap(true)
      require("dap.ext.vscode").json_decode = require("overseer.json").decode

      require("mason").setup(opts)
      local mr = require("mason-registry")
      -- make sure required Debug adapters are installed and configured
      for _, dap_opts in pairs(dap_config.adapters) do
        -- Install using Mason if adapter is missing
        local p = mr.get_package(dap_opts.binary)
        if not p:is_installed() then
          -- Very good very nice
          p:install()
        end
      end

      -- Helper to let user enter binary to debug
      local function pick_program()
        if exe_path then
          return exe_path
        else
          exe_path = vim.fn.input('Path to executable: ')
          return exe_path
        end
      end

      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      -- Setup default DAP configurations for C/C++/Rust
      dap.configurations.cpp = {
        {
          name = "codelldb: Launch Exe",
          type = "codelldb",
          request = "launch",
          program = function()
            return coroutine.create(function(coro)
              local opts = {}
              pickers
                  .new(opts, {
                    prompt_title = "Path to executable",
                    finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(buffer_number)
                      actions.select_default:replace(function()
                        actions.close(buffer_number)
                        coroutine.resume(coro, action_state.get_selected_entry()[1])
                      end)
                      return true
                    end,
                  })
                  :find()
            end)
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },

        {
          name = "codelldb: Attach (select process)",
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
        },

        {
          name = "codelldb: Attach (input pid)",
          type = 'codelldb',
          request = 'attach',
          pid = function()
            return tonumber(vim.fn.input({ prompt = 'pid: ' }))
          end,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

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

      -- /home/max/.local/share/nvim/mason/bin/codelldb
      -- Setup DAP Adapters
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = 'codelldb',
          args = {"--port", "${port}"},

          -- On windows you may have to uncomment this:
          -- detached = false,
        }
      }

      -- dap.adapters.codelldb = {
      --   {
      --     type = 'executable',
      --     port = '13000',
      --     executable = {
      --       command = 'codelldb',
      --       args = { '--port', '13000' },
      --     },
      --   },
      -- }

      -- Breakpoint styling
      vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
      vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
      vim.api.nvim_set_hl(0, "red", { fg = "#FF0000" })

      vim.fn.sign_define('DapBreakpoint',
        { text = '⭕', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition',
        { text = '⚆', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected',
        { text = '❌', texthl = 'blue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped',
        { text = '↳', texthl = 'green', linehl = 'DapStopped', numhl = 'DapStopped' })
      vim.fn.sign_define('DapLogPoint',
        { text = '⭕', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    end,

  },

}
