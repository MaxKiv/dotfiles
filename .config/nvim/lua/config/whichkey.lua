local M = {}

function M.setup()
  local whichkey = require("which-key")

  local conf = {
    window = {
      border = "shadow", -- none, single, double, shadow
      position = "bottom", -- bottom, top
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
    ["gi"] = { "<cmd>Telescope lsp_implementations <CR>", "Find Implementation" },
    ["gr"] = { "<cmd>Telescope lsp_references <CR>", "Find References" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions <CR>", "Type Definition" },
    ["gs"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols <CR>", "List Workspace Symbols" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Symbol " },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic" },
  }

  local mappings = {
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

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    t = {
      name = "Telescope",
      l = { "<cmd>Telescope<CR>", "Telescopic Johnson" }, -- Fuzzy find pickers, then fuzzy find using the picker omg
      f = { "<cmd>Telescope find_files<CR>", "Find files" },
      g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
      c = { "<cmd>Telescope find_files cdw=~/.config/nvim/ <CR>", "Configuration" },
      a = { "<cmd>Telescope find_files cdw=~/ <CR>", "Home directory" }, -- all :)
      r = { "<cmd>Telescope oldfiles<CR>", "Recently used files" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
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
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
      e = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Show All Diagnostics"},
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
  whichkey.register(mappings_no_leader, opts_no_leader)
end

return M

