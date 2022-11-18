-- LSP_SERVERS = { "hls", "sumneko_lua", "rust_analyzer", "clangd", "bashls", "cmake", "omnisharp_mono" }
LSP_SERVERS = { "hls", "sumneko_lua", "rust_analyzer", "clangd", "cmake", "omnisharp", "lemminx" }

-- TODO
-- Refactoring nvim plugin fix

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

    ---- Colorscheme
    -- Gruvbox
    use {
      "morhetz/gruvbox",
      config = function()
        vim.cmd "colorscheme gruvbox"
      end,
    }

    -- -- Solarized light
    -- use {
    --   "shaunsingh/solarized.nvim",
    --   config = function()
    --     require('solarized').set()
    --   end,
    -- }

    -- Telescopic Johnson the bringer of joy
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "cljoly/telescope-repo.nvim",},
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "ThePrimeagen/harpoon" },
        { "nvim-telescope/telescope-fzf-native.nvim" , run = 'make' },
      },
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {}
            },
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case", --  "smart_case", "ignore_case" or "respect_case"
            },
          }
        })
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("repo")
        require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("refactoring")
        require("telescope").load_extension("harpoon")
        -- require('telescope').load_extension('dap')
        -- require("config.telescope").setup()
      end
    }

    -- change working directory automatically for each buffer
    use {
      "notjedi/nvim-rooter.lua",
      config = function()
        require("config.glow").setup()
      end,
    }

    -- Markdown preview
    use({
      "ellisonleao/glow.nvim",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })

    -- Diff tool
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Get full file path
    use("diegoulloao/nvim-file-location")

    -- Better surround
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })
    -- old Surround
    --use { "tpope/vim-surround", }

    -- Comments
    use { "tpope/vim-commentary", }

    -- Spearfishing
    use { "ThePrimeagen/harpoon",
      requires = {"nvim-lua/plenary.nvim"},
    }

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

    -- -- Ascii image viewer :)
    -- use {
    --   'samodostal/image.nvim',
    --   requires = {
    --     'nvim-lua/plenary.nvim'
    --   },
    --   config = function()
    --     require('image').setup()
    --   end
    -- }

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
    use {"nvim-treesitter/playground" }


    -- Docs generation
    use {
      "danymat/neogen",
      config = function()
        require('neogen').setup {}
      end,
      requires = "nvim-treesitter/nvim-treesitter",
      -- Uncomment next line if you want to follow only stable versions
      -- tag = "*"
    }

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
          ensure_installed = { "sumneko_lua", "rust_analyzer", "clangd" },
          automatic_intallation = true,
        })
      end,
      after = "mason.nvim",
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      after = "mason-lspconfig.nvim",
    }

    -- Completion
    use {
      "onsails/lspkind-nvim", -- better looking cmp window, setup in cmp.lua
    }
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-path")
    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").setup()
      end,
      -- after = "onsails/lspkind-nvim",
    }

    -- Refactoring 
    use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
      },
      config = function()
        require("config.refactor").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      config = function()
        require("config.dap").setup()
      end,
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
