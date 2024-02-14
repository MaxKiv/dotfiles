return {

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      triggers_blacklist = {
          i = { "j", "k", "<c-r>" },
          v = { "j", "k" },
        },
    },

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      local vopts = {
        mode = "v", -- Normal mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true, -- use 'nowait' when creating keymaps
      }
      local vnore = {
        u = { [[<cmd>'<,'>g/^\(.*\)\n\_.*\(^\1$\)/d<CR>]], "Keep only unique lines" },
      }
      wk.register(vnore, vopts)

      local nopts_noleader = {
        mode = "n", -- Normal mode
        prefix = "",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true, -- use 'nowait' when creating keymaps
      }
      local nnore_noleader = {
        g = {
          d = {"<cmd>Telescope lsp_definitions<CR>", "Goto Definition"},
          r = {"<cmd>Telescope lsp_references<CR>", "Symbol references"},
          p = {"<cmd>Telescope lsp_implementations<CR>", "Goto implementation"},
          o = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration"},
        },
        K = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Symbol hover"},
      }

      wk.register(nnore_noleader, nopts_noleader)

      local nopts = {
        mode = "n", -- Normal mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true, -- use 'nowait' when creating keymaps
      }
      local nnore = {
        c = {
          name = "Config",
          r = { "<cmd>source $MYVIMRC<CR>", "Reload" },
          c = { "<cmd>Telescope find_files cwd=~/.config/<CR>", "Configuration" },
          g = { "<cmd>Neogit", "Configuration" },
        },

        d = { "<cmd>lua require('neogen').generate()<CR>", "Generate Docs" },

        e = {
          name = "Exec",
          r = { "<cmd>!explorer.exe .<CR>", "Project root" },
          l = { "<cmd>lua dofile(vim.fn.expand('%:p'))<CR>", "current file luajit" },
        },

        p = { "<cmd>lua NvimFileLocation.copy_file_location('absolute', true, false)<cr>", "copy full file path" },

        a = {
          name = "Format",
          w = { [[<cmd>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR><CR>]], "Remove trailing whitespaces" },
          e = { [[<cmd>:g/^\s*$/d<CR>]], "Remove empty lines" },
        },

        m = { "<cmd>Glow<CR>", "View Markdown" },

        -- g = { "<cmd>Neogit<CR>", "Neogit"},

        h = {
          name = "Harpoon",
          m = { [[<cmd>lua require("harpoon.mark").add_file()<Cr>]], "Mark" },
          f = { [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<Cr>]], "Menu" },
        },

        f = {
          name = "Find",
          u = { "<cmd>Telescope undo<CR>", "Undo list" },
          j = { [[<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>]],
            "Find files" },
          e = { "<cmd>Telescope file_browser<CR>", "File browser" },
          [";"] = { "<cmd>Telescope git_files<CR>", "Git Tracked" },
          a = { "<cmd>Telescope find_files cwd=~/<CR>", "Home directory" },
          l = { "<cmd>Telescope oldfiles<CR>", "Recently used files" },
          r = { "<cmd>Telescope repo list<CR>", "Repos" },
          b = { "<cmd>Telescope buffers<CR>", "Buffers" },
          d = { "<cmd>Telescope help_tags<CR>", "Help tags" },
          m = { "<cmd>Telescope marks<CR>", "Marks" },
          p = { "<cmd>Telescope registers<CR>", "Registers" },
          o = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
          k = { "<cmd>Telescope resume<CR>", "Resume previous state" },
          t = { "<cmd>Telescope find_files cwd=~/.todo<CR>", "Todos" },
          i = { "<cmd>Telescope find_files cwd=~/git/Information<CR>", "Home directory" },
          f = { "<cmd>Telescope file_browser<CR>", "File Browser" },
        },

        j = {
          name = "Grep",
          f = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]], "Live grep" },
          d = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>")})<CR>]],
            "Grep Word" },
          s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
          a = { "<cmd>Telescope treesitter<CR>", "Treesitter Symbols" },
          k = { "<cmd>Telescope resume<CR>", "Resume previous state" },
        },

        l = {
          name = "LSP",
          i = { "<cmd>Telescope lsp_incoming_calls<CR>", "List incoming calls" },
          o = { "<cmd>Telescope lsp_outgoing_calls<CR>", "List outgoing calls" },
          d = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Dir" },
          x = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Dir" },
          l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Dirs" },
          r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
          -- a = { "<cmd>lua require'telescope.builtin'.lsp_code_actions{}<CR>", "Code Actions" },
          a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
          -- e = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Show All Diagnostics"},
          e = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Show All Diagnostics" },
          s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
          f = { "<cmd>lua vim.lsp.buf.format({async = true })<CR>", "Format file" },
          j = { "<cmd>LspInfo<CR>", "LSP Info" },
          -- fr = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Formate range" },
          h = { "<cmd>ClangdSwitchSourceHeader<CR>", "Source/Header" }, -- clangd switch to Header...
        },
      }

      wk.register(nnore, nopts)

    end,

    -- config = function()
    --   require("which-key").setup({
    --     plugins = {
    --       marks = true, -- shows a list of your marks on ' and `
    --       registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --       spelling = {
    --         enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --         suggestions = 10, -- how many suggestions should be shown in the list?
    --       },
    --       -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --       -- No actual key bindings are created
    --       presets = {
    --         operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --         motions = true, -- adds help for motions
    --         text_objects = true, -- help for text objects triggered after entering an operator
    --         windows = true, -- default bindings on <c-w>
    --         nav = true, -- misc bindings to work with windows
    --         z = true, -- bindings for folds, spelling and others prefixed with z
    --         g = true, -- bindings for prefixed with g
    --       },
    --     },
    --     window = {
    --       border = "none", -- none, single, double, shadow
    --       position = "bottom", -- bottom, top
    --     },
    --     triggers_blacklist = {
    --       i = { "j", "k", "<c-r>" },
    --       v = { "j", "k" },
    --     },
    --   })
    -- end

  },

}
