local M = {}

function M.setup()
  local whichkey = require("which-key")

  local conf = {
    window = {
      border = "shadow", -- none, single, double, shadow
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

  local mappings_no_leader = {
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Find Declarations" },
    ["gd"] = { "<cmd>Telescope lsp_definitions <CR>", "Find Definitions" },
    -- ["gi"] = { "<cmd>Telescope lsp_implementations <CR>", "Find Implementation" },
    ["gr"] = { "<cmd>Telescope lsp_references <CR>", "Find References" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions <CR>", "Type Definition" },
    ["gs"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols <CR>", "List Workspace Symbols" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Symbol " },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic" },
  }

  -- Visual mode
  local vnore = {
    r = {
      name = "Refactor Menu",
      r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>"},
    }
  }

  -- Normal mode
  local nnore = {
    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      n = { "<Cmd>:bnext<Cr>", "Next buffer" },
      p = { "<Cmd>:bprevious<Cr>", "Previous buffer" },
      b = { "<Cmd>ls<Cr>", "List current buffers" },
      D = { "<Cmd>%db|e#|bd#<Cr>", "Delete all buffers" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    c = {
      name = "Config",
      r = { "<cmd>source $MYVIMRC<CR>", "Reload" },
      f = { "<cmd>Telescope find_files cwd=~/.config/<CR>", "Configuration" },
    },

    e = {
      name = "Exec",
      r = { "<cmd>!explorer.exe .<CR>", "Project root" },
      l = { "<cmd>!luajit %<CR>", "luajit" },
      -- f = {},
    },

    -- s = {
    --   name = "SVN",
    --   i = { "<cmd>!svn<CR>", "File Log" },
    -- },

    f = {
      name = "Format",
      w = { [[<cmd>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR><CR>]], "Remove trailing whitespaces" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    t = {
      name = "Telescope",
      l = { "<cmd>Telescope<CR>", "Telescopic Johnson" }, -- Fuzzy find pickers, then fuzzy find using the picker omg
      f = { "<cmd>Telescope find_files<CR>", "Find files" },
      -- g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
      g = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]], "Live grep" },
      w = { [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>")})<CR>]], "Grep Word" },
      a = { "<cmd>Telescope find_files cwd=~/<CR>", "Home directory" }, -- all :)
      r = { "<cmd>Telescope oldfiles<CR>", "Recently used files" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      c = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
      h = { "<cmd>Telescope help_tags<CR>", "Help tags" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
      p = { "<cmd>Telescope registers<CR>", "Registers" },
      j = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
      s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" }, -- Search
      t = { "<cmd>Telescope treesitter<CR>", "Treesitter Symbols" },
      k = { "<cmd>Telescope resume<CR>", "Resume previous state" }, -- Kontinue... ok this is getting hard
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
      e = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Show All Diagnostics"},
      s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols"},
      ff = { "<cmd>lua vim.lsp.buf.format({async = true })<CR>", "Format file"},
      fr = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Formate range"},
      h = { "<cmd>ClangdSwitchSourceHeader<CR>", "Source/Header" }, -- clangd switch to Header...
    },
  }

  whichkey.setup(conf)
  whichkey.register(nnore, opts)
  whichkey.register(vnore, opts)
  whichkey.register(mappings_no_leader, opts_no_leader)
end

-- Similar to <cmd>! but with timeout
local function bang(cmd)
  local pipeHandle = io.popen(tostring(cmd))
  local result = pipeHandle:read("*a")
  pipeHandle:close()
  return tostring(result)
end

-- Extracts path of the given file
local function getFilePath(file)
    local r = string.reverse(file)
    return string.reverse(string.sub(r,string.find(r,"/"), #r))
end

-- Run
function runExpInParentDir()
  local command = "start explorer.exe "
  os.execute(command .. string.gsub(bang("wslpath -w " .. getFilePath(vim.api.nvim_buf_get_name(0))), [[\]], [[\\]]))
end

return M
