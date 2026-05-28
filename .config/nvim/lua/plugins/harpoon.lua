-- Spearfishing
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    config = function()
      local harpoon = require('harpoon')

      harpoon:setup()

      local list = function()
        return harpoon:list()
      end

      -- Mark current file
      vim.keymap.set('n', '<C-e>', function()
        list():add()
      end, { desc = 'Mark Buffer' })

      -- Toggle quick menu
      vim.keymap.set('n', '<S-H>', function()
        harpoon.ui:toggle_quick_menu(list())
      end, { desc = 'View Marks' })

      -- Navigation (F-keys)
      vim.keymap.set('n', '<S-F1>', function()
        list():select(1)
      end, { desc = 'Goto 1' })

      vim.keymap.set('n', '<S-F2>', function()
        list():select(2)
      end, { desc = 'Goto 2' })

      vim.keymap.set('n', '<S-F3>', function()
        list():select(3)
      end, { desc = 'Goto 3' })

      vim.keymap.set('n', '<S-F4>', function()
        list():select(4)
      end, { desc = 'Goto 4' })

      -- Ctrl navigation (your old mapping style preserved)
      vim.keymap.set('n', '<C-h>', function()
        list():select(1)
      end, { desc = 'Goto 1' })

      vim.keymap.set('n', '<C-j>', function()
        list():select(2)
      end, { desc = 'Goto 2' })

      vim.keymap.set('n', '<C-k>', function()
        list():select(3)
      end, { desc = 'Goto 3' })

      vim.keymap.set('n', '<C-l>', function()
        list():select(4)
      end, { desc = 'Goto 4' })
    end,
  },
}
