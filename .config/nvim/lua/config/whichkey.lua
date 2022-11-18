local M = {}

function M.setup()
  local whichkey = require("which-key")

  local conf = {
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
    triggers_blacklist = {
      i = { "j", "k", "<c-r>" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
  }
  local opts_no_leader = {
    mode = "n", -- Normal mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
  }
  local vopts = {
    mode = "v", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
  }

  local mappings_no_leader = {
    -- LSP
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Find Declarations" },
    ["gd"] = { "<cmd>Telescope lsp_definitions <CR>", "Find Definitions" },
    ["gp"] = { "<cmd>Telescope lsp_implementations <CR>", "Find Implementation" },
    ["gr"] = { "<cmd>Telescope lsp_references <CR>", "Find References" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions <CR>", "Type Definition" },
    ["gs"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols <CR>", "List Workspace Symbols" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Symbol " },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic" },

    -- Harpoon
    ["<C-j>"] = { [[<cmd>lua require("harpoon.ui").nav_file(1)<Cr>]], "goto file 1" },
    ["<C-k>"] = { [[<cmd>lua require("harpoon.ui").nav_file(2)<Cr>]], "goto file 2" },
    ["<C-l>"] = { [[<cmd>lua require("harpoon.ui").nav_file(3)<Cr>]], "goto file 3" },
    ["<C-;>"] = { [[<cmd>lua require("harpoon.ui").nav_file(4)<Cr>]], "goto file 4" },
  }

  -- Visual mode
  local vnore = {
    r = {
      name = "Refactor Menu",
      r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>" },
    },
    u = { [[<cmd>'<,'>g/^\(.*\)\n\_.*\(^\1$\)/d<CR>]], "Keep only unique lines" },
  }

  -- Normal mode
  local nnore = {

    c = {
      name = "Config",
      r = { "<cmd>source $MYVIMRC<CR>", "Reload" },
      c = { "<cmd>Telescope find_files cwd=~/.config/<CR>", "Configuration" },
    },

    d = { "<cmd>lua require('neogen').generate()<CR>", "Generate Docs" },

    e = {
      name = "Exec",
      r = { "<cmd>!explorer.exe .<CR>", "Project root" },
      --TODO make this the neovim lua interpreter, as that should always be there
      -- l = { "<cmd>!luajit %<CR>", "current file luajit" },
      l = { "<cmd>lua %<CR>", "current file luajit" },
    },

    p = { "<cmd>lua NvimFileLocation.copy_file_location('absolute', true, false)<cr>", "copy full file path" },

    a = {
      name = "Format",
      w = { [[<cmd>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR><CR>]], "Remove trailing whitespaces" },
      e = { [[<cmd>:g/^\s*$/d<CR>]], "Remove empty lines" },
    },

    m = { "<cmd>Glow<CR>", "View Markdown" },

    s = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    h = {
      name = "Harpoon",
      m = { [[<cmd>lua require("harpoon.mark").add_file()<Cr>]], "Mark" },
      f = { [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<Cr>]], "Menu" },
    },

    f = {
      name = "Find",
      u = { "<cmd>Telescope<CR>", "Telescopic Johnson" },
      j = { [[<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>]], "Find files" },
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
    },

    j = {
      name = "Grep",
      f = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]], "Live grep" },
      d = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>")})<CR>]], "Grep Word" },
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
      ff = { "<cmd>lua vim.lsp.buf.format({async = true })<CR>", "Format file" },
      fr = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Formate range" },
      h = { "<cmd>ClangdSwitchSourceHeader<CR>", "Source/Header" }, -- clangd switch to Header...
    },
  }

  whichkey.setup(conf)
  whichkey.register(nnore, opts)
  whichkey.register(vnore, vopts)
  whichkey.register(mappings_no_leader, opts_no_leader)

end

-- Similar to <cmd>! but with timeout
local function bang(cmd)
  local pipeHandle = io.popen(tostring(cmd))
  if not pipeHandle then return end
  local result = pipeHandle:read("*a")
  pipeHandle:close()
  return tostring(result)
end

-- Extracts path of the given file
local function getFilePath(file)
  local r = string.reverse(file)
  return string.reverse(string.sub(r, string.find(r, "/"), #r))
end

-- Run
function runExpInParentDir()
  local command = "start explorer.exe "
  os.execute(command .. string.gsub(bang("wslpath -w " .. getFilePath(vim.api.nvim_buf_get_name(0))), [[\]], [[\\]]))
end

return M
