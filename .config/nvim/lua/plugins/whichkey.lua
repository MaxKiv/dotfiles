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
        mode = "v",     -- Normal mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true,  -- use 'nowait' when creating keymaps
      }
      local vnore = {
        u = { [[<cmd>'<,'>g/^\(.*\)\n\_.*\(^\1$\)/d<CR>]], "Keep only unique lines" },
      }
      wk.register(vnore, vopts)

      local nopts_noleader = {
        mode = "n",     -- Normal mode
        prefix = "",
        buffer = nil,   -- global mappings. specify a buffer number for buffer local mappings
        silent = true,  -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true,  -- use 'nowait' when creating keymaps
      }
      local nnore_noleader = {
        g = {
          d = { "<cmd>Telescope lsp_definitions<CR>", "Goto Definition" },
          r = { "<cmd>Telescope lsp_references<CR>", "Symbol references" },
          p = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
          o = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
          j = { "<cmd>diffget<CR>", "Diff Get" },
          f = { "<cmd>diffput><CR>", "Diff Put" },
        },

        K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Symbol hover" },

        ["<C-j>"] = { "<cmd>tabprev<CR>", "Prev Tab" },
        ["<C-k>"] = { "<cmd>tabnext<CR>", "Next Tab" },

        ["]h"] = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
        ["[h"] = { "<cmd>Gitsigns prev_hunk<CR>", "Prev Hunk" },

        ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        ["]e"] = { [[<cmd>lua vim.diagnostic.goto_next({severity = ERROR})<cr>]], "Next Error" },
        ["[e"] = { [[<cmd>lua vim.diagnostic.goto_prev({severity = ERROR})<cr>]], "Prev Error" },
        ["]w"] = { [[<cmd>lua vim.diagnostic.goto_next({severity = WARN})<cr>]], "Next Warning" },
        ["[w"] = { [[<cmd>lua vim.diagnostic.goto_prev({severity = WARN})<cr>]], "Prev Warning" },

        ["<C-w>|"] = { [[<cmd>vsplit<cr>]], "Prev Warning" },
        ["<C-w>-"] = { [[<cmd>split<cr>]], "Prev Warning" },

      }
      wk.register(nnore_noleader, nopts_noleader)

      local nopts = {
        mode = "n",     -- Normal mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true,  -- use 'nowait' when creating keymaps
      }
      local nnore = {
        [':'] = { "<cmd>lua require('telescope.builtin').commands()<CR>", "Commands" },

        c = { "<cmd>lua require'telescope.builtin'.find_files({cwd= vim.fn.expand('$HOME/.config') })<CR>",
          "Browse dotfiles" },

        g = {
          name = "Git",
          j = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_branch_file()<cr>",
            "Search local branches" },
          k = { "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content()<cr>", "Search git log" },
          l = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>",
            "Search line changes" },
          f = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_file()<cr>",
            "Search file changes" },
          [';'] = { "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content_file()<cr>",
            "Search git log" },
          a = { "<cmd>lua require('telescope').extensions.advanced_git_search.checkout_reflog()<cr>", "Search git reflog" },
          s = { "<cmd>Neogit<cr>", "Neogit" },
          S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
          r = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
          p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
          b = { "<cmd>lua function() gs.blame_line({ full = true }) end <cr>", "Blame line" },
          d = { "<cmd>DiffviewOpen<cr>", "Open Diffview" },
          c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
          D = { "<cmd>lua function() gs.diffthis end<cr>", "Diff This" },
          m = {
            [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = "<<<<<<<"})<CR>]],
            "Git markers in project" },
        },

        e = {
          name = "Exec",
          r = { "<cmd>!explorer.exe .<CR>", "File explorer project root" },
          p = { "<cmd>!start %:p:h<CR>", "File explorer current file" },
          t = { "<cmd>!start alacritty.exe<CR>", "Terminal project root" },
          l = { "<cmd>lua dofile(vim.fn.expand('%:p'))<CR>", "current file luajit" },
        },

        p = { "<cmd>lua require('functions').copy_file_path()<cr>", "copy full file path" },

        a = {
          name = "Format",
          w = { [[<cmd>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR><CR>]], "Remove trailing whitespaces" },
          e = { [[<cmd>:g/^\s*$/d<CR>]], "Remove empty lines" },
        },

        -- m = { "<cmd>Glow<CR>", "View Markdown" },

        f = {
          name = "Find",
          u = { "<cmd>Telescope undo<CR>", "Undo list" },
          j = {
            [[<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>]],
            "Find files" },
          e = { "<cmd>Telescope file_browser<CR>", "File browser" },
          [";"] = { "<cmd>Telescope git_files<CR>", "Git Tracked" },
          a = { "<cmd>Telescope find_files cwd=~/<CR>", "Home directory" },
          l = { "<cmd>Telescope oldfiles<CR>", "Recently used files" },
          r = { "<cmd>Telescope repo list<CR>", "Repos" },
          B = { "<cmd>Telescope buffers<CR>", "Buffers" },
          d = { "<cmd>Telescope help_tags<CR>", "Help tags" },
          m = { "<cmd>Telescope marks<CR>", "Marks" },
          p = { "<cmd>Telescope registers<CR>", "Registers" },
          o = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
          k = { "<cmd>Telescope resume<CR>", "Resume previous state" },
          t = { "<cmd>Telescope find_files cwd=~/.todo<CR>", "Todos" },
          i = { "<cmd>Telescope find_files cwd=~/git/Information<CR>", "Notes" },
        },

        j = {
          name = "Grep",
          f = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]], "Live grep" },
          d = {
            [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>")})<CR>]],
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

        x = {
          x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
          q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
          w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
          d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
        },

      }

      wk.register(nnore, nopts)
    end,
  },

}
