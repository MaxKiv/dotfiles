local M = {}

function M.setup()
  local whichkey = require("which-key")

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
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

  local mappings = {

    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Find Declarations (LSP)" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Find Definition (LSP)" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Find Implementation (LSP)" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find References (LSP)" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.workspace_symbols()<CR>", "Find Workspace Symbols (LSP)" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Symbol (LSP)" },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help (LSP)" },
    ["gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition (LSP)" },
    ["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Goto previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Goto next diagnostic" },

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
      l = { "<cmd>Telescope<CR>", "Telescopic Johnson" },
      f = { "<cmd>Telescope find_files<CR>", "Find files" },
      g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      h = { "<cmd>Telescope help_tags<CR>", "Help tags" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
      r = { "<cmd>Telescope registers<CR>", "Registers" },
      j = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
      s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
      t = { "<cmd>Telescope treesitter<CR>", "Treesitter Symbols" },
    },

    l = {
      name = "LSP",
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
end

return M

