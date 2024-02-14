return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = nil, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = "BufReadPost",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },

    ---@type TSConfig
    opts = {
      -- A list of parser names, or "all"
      ensure_installed = {
        "lua",
        "vim",
        "c",
        "python",
        "help",
        "query",
        "git_rebase",
        "markdown",
        "markdown_inline",
        "rust",
        "cpp",
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = true,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- Highlight using treesitters abstract syntax tree
      highlight = { enable = true, },

      -- Use treesitter to find correct indentation levels
      indent = { enable = true, },

      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        }
      },

      -- Treesitter text objects 🙌
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

        swap = {
          enable = true,
          swap_next = {
            ["cxn"] = "@parameter.inner",
          },
          swap_previous = {
            ["cxp"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]a"] = "@parameter.outer",
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[a"] = "@parameter.outer",
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      }
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
