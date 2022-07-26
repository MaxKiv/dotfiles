local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- Highlight using treesitters abstract syntax tree
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },

    -- Use treesitter to find correct indentation levels
    indent = {
      enable = true,
    },

    -- Enable incremental selection
    incremental_selection = {
      enable= true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      }
    },

    -- Treesitter text objects :praise
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
    },
  }

  -- Options
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

end

return M
