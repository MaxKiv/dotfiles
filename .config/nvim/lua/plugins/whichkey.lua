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
      wk.add({
        {
          -- General
          { "<leader>w",   "<cmd>w<cr>",                                                            desc = "Save file",            nowait = true, remap = false },
          { "<CR>",        "ciw",                                                                   desc = "bam!",                 nowait = true, remap = false },
          { "<C-CR>",      "daw",                                                                   desc = "bam!",                 nowait = true, remap = false },
          { "<S-CR>",      [[f"ci"]],                                                               desc = "bam!!",                nowait = true, remap = false },

          -- window management
          { "<C-A-Down>",  "<cmd resize -5<cr>",                                                    desc = "resize -5",            nowait = true, remap = false },
          { "<C-A-j>",     "<cmd resize -5<cr>",                                                    desc = "resize -5",            nowait = true, remap = false },
          { "<C-A-Left>",  "<cmd>vertical resize -5<cr>",                                           desc = "vertical resize -5",   nowait = true, remap = false },
          { "<C-A-h>",     "<cmd>vertical resize -5<cr>",                                           desc = "vertical resize -5",   nowait = true, remap = false },
          { "<C-A-Right>", "<cmd>vertical resize +5<cr>",                                           desc = "vertical resize +5",   nowait = true, remap = false },
          { "<C-A-l>",     "<cmd>vertical resize +5<cr>",                                           desc = "vertical resize +5",   nowait = true, remap = false },
          { "<C-A-Up>",    "<cmd> resize +5<cr>",                                                   desc = "resize +5",            nowait = true, remap = false },
          { "<C-A-k>",     "<cmd> resize +5<cr>",                                                   desc = "resize +5",            nowait = true, remap = false },

          -- Tabs
          { "<C-Left>",    "<cmd>tabprev<CR>",                                                      desc = "Prev Tab",             nowait = true, remap = false },
          { "<C-Right>",   "<cmd>tabnext<CR>",                                                      desc = "Next Tab",             nowait = true, remap = false },
          { "<C-n>",       "<cmd>tabprev<CR>",                                                      desc = "Prev Tab",             nowait = true, remap = false },
          { "<C-p>",       "<cmd>tabnext<CR>",                                                      desc = "Next Tab",             nowait = true, remap = false },

          -- Splits
          { "<C-w>-",      "<cmd>split<cr>",                                                        desc = "open split",           nowait = true, remap = false },
          { "<C-w>s",      "<cmd>split<cr>",                                                        desc = "open split",           nowait = true, remap = false },
          { "<C-w>v",      "<cmd>vsplit<cr>",                                                       desc = "open vsplit",          nowait = true, remap = false },
          { "<C-w>|",      "<cmd>vsplit<cr>",                                                       desc = "open vsplit",          nowait = true, remap = false },

          -- Next/Previous pairs
          { "]e",          "<cmd>lua vim.diagnostic.goto_next({severity = ERROR})<cr>",             desc = "Next Error",           nowait = true, remap = false },
          { "[e",          "<cmd>lua vim.diagnostic.goto_prev({severity = ERROR})<cr>",             desc = "Prev Error",           nowait = true, remap = false },
          { "]w",          "<cmd>lua vim.diagnostic.goto_next({severity = WARN})<cr>",              desc = "Next Warning",         nowait = true, remap = false },
          { "[w",          "<cmd>lua vim.diagnostic.goto_prev({severity = WARN})<cr>",              desc = "Prev Warning",         nowait = true, remap = false },
          { "[h",          "<cmd>Gitsigns prev_hunk<CR>",                                           desc = "Prev Hunk",            nowait = true, remap = false },
          { "]h",          "<cmd>Gitsigns next_hunk<CR>",                                           desc = "Next Hunk",            nowait = true, remap = false },

          -- Helix like movement mappings
          { "gh",          "^",                                                                     desc = "to line start",        nowait = true, remap = false },
          { "gl",          "$",                                                                     desc = "to line end",          nowait = true, remap = false },
          { "gk",          "gg",                                                                    desc = "to file start",        nowait = true, remap = false },
          { "gj",          "G",                                                                     desc = "to file end",          nowait = true, remap = false },

          -- LSP
          { "gd",          "<cmd>Telescope lsp_definitions<CR>",                                    desc = "Goto Definition",      nowait = true, remap = false },
          { "go",          "<cmd>lua vim.lsp.buf.declaration()<CR>",                                desc = "Goto declaration",     nowait = true, remap = false },
          { "gp",          "<cmd>lua vim.lsp.buf.implementation()<CR>",                             desc = "Goto implementation",  nowait = true, remap = false },
          { "gr",          "<cmd>Telescope lsp_references<CR>",                                     desc = "Symbol references",    nowait = true, remap = false },
          { "<leader>l",   group = "LSP",                                                           nowait = true,                 remap = false },
          { "<leader>la",  "<cmd>lua vim.lsp.buf.code_action()<CR>",                                desc = "Code Actions",         nowait = true, remap = false },
          { "<leader>ld",  "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",                       desc = "Add Workspace Dir",    nowait = true, remap = false },
          { "<leader>le",  "<cmd>lua vim.diagnostic.setloclist()<CR>",                              desc = "Show All Diagnostics", nowait = true, remap = false },
          { "<leader>lf",  "<cmd>lua vim.lsp.buf.format({async = true })<CR>",                      desc = "Format file",          nowait = true, remap = false },
          { "<leader>lh",  "<cmd>ClangdSwitchSourceHeader<CR>",                                     desc = "Source/Header",        nowait = true, remap = false },
          { "<leader>li",  "<cmd>Telescope lsp_incoming_calls<CR>",                                 desc = "List incoming calls",  nowait = true, remap = false },
          { "<leader>lj",  "<cmd>LspInfo<CR>",                                                      desc = "LSP Info",             nowait = true, remap = false },
          { "<leader>lk",  "<cmd>LspLog<CR>",                                                       desc = "LSP Log",              nowait = true, remap = false },
          { "<leader>ll",  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List Workspace Dirs",  nowait = true, remap = false },
          { "<leader>lo",  "<cmd>Telescope lsp_outgoing_calls<CR>",                                 desc = "List outgoing calls",  nowait = true, remap = false },
          { "<leader>lr",  "<cmd>lua vim.lsp.buf.rename()<CR>",                                     desc = "Rename Symbol",        nowait = true, remap = false },
          { "<leader>ls",  "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",                      desc = "Workspace Symbols",    nowait = true, remap = false },
          { "<leader>lx",  "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",                    desc = "Remove Workspace Dir", nowait = true, remap = false },
        },

        {
          { "<leader>:",     "<cmd>lua require('telescope.builtin').commands()<CR>",                                                                                                                          desc = "Commands",                         nowait = true, remap = false },

          -- Custom functions
          { "<leader>n",     "<cmd>lua vim.wo.relativenumber = not vim.wo.relativenumber<CR>",                                                                                                                desc = "Toggle relative line number",      nowait = true, remap = false },
          { "<leader><C-p>", "<cmd>lua require('functions').copy_file_path_from_root() print('file root path copied')<cr>",                                                                                   desc = "copy file path from root",         nowait = true, remap = false },
          { "<leader>P",     "<cmd>lua require('functions').copy_file_name() print('file name copied')<cr>",                                                                                                  desc = "copy file name",                   nowait = true, remap = false },
          { "<leader>\\",    "<cmd>lua require('functions').clipboard_switch_brackets() print('Switched clipboard brackets')<cr>",                                                                            desc = "Switch cliboard brackets",         nowait = true, remap = false },
          { "<leader>p",     "<cmd>lua require('functions').copy_file_path() print('file path copied')<cr>",                                                                                                  desc = "copy file path",                   nowait = true, remap = false },
          { "<leader>q",     "<cmd>lua require('functions').join_paragraphs()<CR>",                                                                                                                           desc = "Join paragraphs in file",          nowait = true, remap = false },
          { "<leader>s",     "<cmd>lua require('functions').toggle_diff_splits()<CR>",                                                                                                                        desc = "Toggle diffsplits",                nowait = true, remap = false },
          { "<leader>=",     "<cmd>lua require('functions').accept_first_spelling_suggestion()<CR>",                                                                                                          desc = "Accept first spelling suggestion", nowait = true, remap = false },

          -- Formatting
          { "<leader>a",     group = "Format",                                                                                                                                                                nowait = true,                             remap = false },
          { "<leader>ae",    "<cmd>:g/^\\s*$/d<CR>",                                                                                                                                                          desc = "Remove empty lines",               nowait = true, remap = false },
          { "<leader>aw",    "<cmd>:let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR><CR>",                                                                                                                desc = "Remove trailing whitespaces",      nowait = true, remap = false },

          -- Dotfiles
          { "<leader>c",     "<cmd>lua require'telescope.builtin'.find_files({cwd= vim.fn.expand(require('functions').dotfiles_dir), follow=true, no_ignore=true, hidden=true})<CR>",                         desc = "Browse dotfiles",                  nowait = true, remap = false },

          -- Opening current file in other programs
          { "<leader>e",     group = "Exec",                                                                                                                                                                  nowait = true,                             remap = false },
          { "<leader>el",    "<cmd>lua dofile(vim.fn.expand('%:p'))<CR>",                                                                                                                                     desc = "current file luajit",              nowait = true, remap = false },
          { "<leader>ep",    "<cmd>lua require('functions').open_current_file_in_file_explorer()<CR>",                                                                                                        desc = "File explorer current file",       nowait = true, remap = false },
          { "<leader>er",    "<cmd>lua require('functions').open_project_root_in_file_explorer()<CR>",                                                                                                        desc = "File explorer project root",       nowait = true, remap = false },
          { "<leader>et",    "<cmd>lua require('functions').open_project_root_in_terminal()<CR>",                                                                                                             desc = "Terminal project root",            nowait = true, remap = false },

          -- Finding files
          { "<leader>f",     group = "Find",                                                                                                                                                                  nowait = true,                             remap = false },
          { "<C-f>",         "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",                                                           desc = "Find files",                       nowait = true, remap = false },
          { "<leader>fj",    "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",                                                           desc = "Find files",                       nowait = true, remap = false },
          { "<leader>fk",    "<cmd>Telescope resume<CR>",                                                                                                                                                     desc = "Resume previous state",            nowait = true, remap = false },
          { "<leader>f;",    "<cmd>lua require\"telescope.builtin\".find_files({find_command = { 'rg', '--files', '--iglob', '!.git', '--iglob', '!*.idx', '--hidden'}, hidden = true, no_ignore=true})<CR>", desc = "Hidden files",                     nowait = true, remap = false },
          -- These I dont actually use
          { "<leader>fB",    "<cmd>Telescope buffers<CR>",                                                                                                                                                    desc = "Buffers",                          nowait = true, remap = false },
          { "<leader>fa",    "<cmd>Telescope find_files cwd=~/<CR>",                                                                                                                                          desc = "Home directory",                   nowait = true, remap = false },
          { "<leader>fd",    "<cmd>Telescope help_tags<CR>",                                                                                                                                                  desc = "Help tags",                        nowait = true, remap = false },
          { "<leader>fi",    "<cmd>Telescope find_files cwd=~/git/Information<CR>",                                                                                                                           desc = "Notes",                            nowait = true, remap = false },
          { "<leader>fl",    "<cmd>Telescope oldfiles<CR>",                                                                                                                                                   desc = "Recently used files",              nowait = true, remap = false },
          { "<leader>fm",    "<cmd>Telescope marks<CR>",                                                                                                                                                      desc = "Marks",                            nowait = true, remap = false },
          { "<leader>fo",    "<cmd>Telescope jumplist<CR>",                                                                                                                                                   desc = "Jumplist",                         nowait = true, remap = false },
          { "<leader>fp",    "<cmd>Telescope registers<CR>",                                                                                                                                                  desc = "Registers",                        nowait = true, remap = false },
          { "<leader>fr",    "<cmd>Telescope repo list<CR>",                                                                                                                                                  desc = "Repos",                            nowait = true, remap = false },
          { "<leader>ft",    "<cmd>Telescope find_files cwd=~/.todo<CR>",                                                                                                                                     desc = "Todos",                            nowait = true, remap = false },
          { "<leader>fu",    "<cmd>Telescope undo<CR>",                                                                                                                                                       desc = "Undo list",                        nowait = true, remap = false },

          -- Finding in files
          { "<leader>j",     group = "Grep",                                                                                                                                                                  nowait = true,                             remap = false },
          { "<leader>jd",    '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>")})<CR>',                                                         desc = "Grep Word",                        nowait = true, remap = false },
          { "<leader>jf",    '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>',                                                                                                  desc = "Live grep",                        nowait = true, remap = false },
          { "<leader>js",    "<cmd>Telescope current_buffer_fuzzy_find<CR>",                                                                                                                                  desc = "Current Buffer",                   nowait = true, remap = false },
          { "<leader>jk",    "<cmd>Telescope resume<CR>",                                                                                                                                                     desc = "Resume previous state",            nowait = true, remap = false },
          -- These I dont actually use
          { "<leader>ja",    "<cmd>Telescope treesitter<CR>",                                                                                                                                                 desc = "Treesitter Symbols",               nowait = true, remap = false },

          -- Git
          { "<leader>g",     group = "Git",                                                                                                                                                                   nowait = true,                             remap = false },
          { "<leader>g;",    "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content_file()<cr>",                                                                                    desc = "Search git file log",              nowait = true, remap = false },
          { "<leader>gD",    '<cmd>lua require("gitsigns").diffthis()<cr>',                                                                                                                                   desc = "Diff This",                        nowait = true, remap = false },
          { "<leader>gS",    "<cmd>Gitsigns stage_buffer<cr>",                                                                                                                                                desc = "Stage Buffer",                     nowait = true, remap = false },
          { "<leader>gb",    '<cmd>lua require("gitsigns").blame_line()<cr>',                                                                                                                                 desc = "Blame line",                       nowait = true, remap = false },
          { "<leader>gc",    "<cmd>DiffviewClose<cr>",                                                                                                                                                        desc = "Close Diffview",                   nowait = true, remap = false },
          { "<leader>gd",    "<cmd>DiffviewOpen<cr>",                                                                                                                                                         desc = "Open Diffview",                    nowait = true, remap = false },
          { "<leader>gk",    "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content()<cr>",                                                                                         desc = "Search git log",                   nowait = true, remap = false },
          { "<leader>gl",    "<cmd>Git log -p --follow %<cr>",                                                                                                                                                desc = "Git file log",                     nowait = true, remap = false },
          { "<leader>gm",    '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = "<<<<<<<"})<CR>',                                                                        desc = "Git markers in project",           nowait = true, remap = false },
          { "<leader>gp",    "<cmd>Gitsigns preview_hunk<cr>",                                                                                                                                                desc = "Preview Hunk",                     nowait = true, remap = false },
          { "<leader>gr",    "<cmd>Gitsigns reset_buffer<cr>",                                                                                                                                                desc = "Reset Buffer",                     nowait = true, remap = false },
          { "<leader>go",    "<cmd>Git checkout --ours -- %<cr>",                                                                                                                                             desc = "Checkout ours",                    nowait = true, remap = false },
          { "<leader>gt",    "<cmd>Git checkout --theirs -- %<cr>",                                                                                                                                           desc = "Checkout theirs",                  nowait = true, remap = false },
          -- Neogit
          { "<leader>gs",    "<cmd>Neogit<cr>",                                                                                                                                                               desc = "Neogit",                           nowait = true, remap = false },

          -- Oil
          { "<leader>o",     "<cmd>lua require('oil').toggle_float()<CR>",                                                                                                                                    desc = "Toggle oil float",                 nowait = true, remap = false },
        }
      })
    end,
  },

}
