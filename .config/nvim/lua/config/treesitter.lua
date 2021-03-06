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
          -- ["ix"] = "@statement.inner",
        },
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },

    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    --   goto_next_start = {
    --     ["]m"] = "@function.outer",
    --     ["]]"] = "@class.outer",
    --   },
    --   goto_next_end = {
    --     ["]M"] = "@function.outer",
    --     ["]["] = "@class.outer",
    --   },
    --   goto_previous_start = {
    --     ["[m"] = "@function.outer",
    --     ["[["] = "@class.outer",
    --   },
    --   goto_previous_end = {
    --     ["[M"] = "@function.outer",
    --     ["[]"] = "@class.outer",
    --   },
    -- },

  }

  function test(arg3, arg, arg2) 
    -- comment
    for key, value in pairs(table) do 
      --another
      if(test) then
        youwin()
      end
    end
  end

  -- Options
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

end

return M
