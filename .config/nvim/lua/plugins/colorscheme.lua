return {

  {
    "eddyekofo94/gruvbox-flat.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- -- load the colorscheme here
      -- vim.g.gruvbox_flat_style = "dark"
      -- vim.cmd [[colorscheme gruvbox-flat]]
      --
      -- vim.cmd [[highlight Normal guibg=none]]
      -- vim.cmd [[highlight NonText guibg=none]]
    end,
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      term_colors = true,
      transparent_background = true,
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.1, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        telescope = true,
        mason = true,
        neotree = true,
        neogit = true,
        noice = true,
        notify = true,
        which_key = true,
        dap = true,
        navic = true,
        dap_ui = true,
        fidget = true,
        nvim_surround = true,
        overseer = true,
        lsp_trouble = true,
        diffview = true;
        indent_blankline = true;
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  }

}
