return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },

    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
    },

    opts = {
      ensure_installed = {
        'c',
        'cpp',
        'rust',
        'python',
        'nix',
      },

      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,

        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',

            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',

            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',

            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',

            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
          },

          -- recommended on 0.12+
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },

          include_surrounding_whitespace = true,
        },

        swap = {
          enable = true,

          swap_next = {
            ['cxn'] = '@parameter.inner',
          },

          swap_previous = {
            ['cxp'] = '@parameter.inner',
          },
        },

        move = {
          enable = true,
          set_jumps = true,

          goto_next_start = {
            [']a'] = '@parameter.outer',
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',

            [']o'] = '@loop.outer',

            [']s'] = {
              query = '@scope',
              query_group = 'locals',
              desc = 'Next scope',
            },

            [']z'] = {
              query = '@fold',
              query_group = 'folds',
              desc = 'Next fold',
            },
          },

          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },

          goto_previous_start = {
            ['[a'] = '@parameter.outer',
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },

          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },

          goto_next = {
            [']i'] = '@conditional.outer',
          },

          goto_previous = {
            ['[i'] = '@conditional.outer',
          },
        },
      },
    },
  },
}
