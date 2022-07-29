LSP_SERVERS = { "sumneko_lua", "rust_analyzer", "clangd" }

local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    -- Packer plugin manager
    use { "wbthomason/packer.nvim" }

    -- -- Colorscheme
    -- use {
    --   "Yazeed1s/minimal.nvim",
    --   config = function()
    --     vim.cmd "colorscheme minimal"
    --   end,
    -- }

    -- Colorscheme
    use {
      "morhetz/gruvbox",
      config = function()
        vim.cmd "colorscheme gruvbox"
      end,
    }

    -- Telescopic Johnson
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = { {"nvim-lua/plenary.nvim"} },
      -- config = function()
      --   require("config.telescope").setup()
      -- end,
    }

    -- Better surround
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })

    -- -- Surround
    use { "tpope/vim-commentary", }
    -- old Surround
    --use { "tpope/vim-surround", }

    -- Lualine statusbar
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

    -- Whichkey
    use {
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- nvim-gps to show current scope we are working in
    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      module = "nvim-gps",
      config = function()
        require("nvim-gps").setup()
      end,
    }

    -- IDE stuff
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
    }
    use {"nvim-treesitter/nvim-treesitter-textobjects" }

    -- -- Language Server Protocol LSP stuff
    -- -- Autocompletion engine
    -- use {
    --   "hrsh7th/nvim-cmp",
    --   config = function()
    --     require("config.cmp").setup()
    --   end,
    -- }
    -- -- Autocomplete sources
    -- use { "hrsh7th/cmp-nvim-lsp",
    --       after = "nvim-cmp" }
    -- use { "hrsh7th/cmp-buffer",
    --       after = "nvim-cmp" }
    -- use {"hrsh7th/cmp-path",
    --       after = "nvim-cmp" }
    -- use {"hrsh7th/cmp-cmdline",
    --       after = "nvim-cmp" }

    -- LSP
    -- LSP installer
    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    }

    -- LSP config
    use {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "sumneko_lua", "rust_analyzer@nightly", "clangd" },
          automatic_intallation = true,
        })
      end,
    }
    use {
        "neovim/nvim-lspconfig",
        config = function()
          require("config.lsp").setup()
        end,
    }

    -- use { "williamboman/nvim-lsp-installer" }
    -- require("nvim-lsp-installer").setup()

    -- use { "neovim/nvim-lspconfig" }
    -- require("lspconfig")

    -- use { "neovim/nvim-lspconfig",
    --   -- after = "cmp-nvim-lsp",
    --   config = function()
    --     require("config.lsp-config").setup()
    --   end,
    -- }

    -- -- Snippets
    -- use "L3MON4D3/LuaSnip"
    -- use "rafamadriz/friendly-snippets"


    -- Bootstrap Neovim
    if packer_bootstrap then
      pgint "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
