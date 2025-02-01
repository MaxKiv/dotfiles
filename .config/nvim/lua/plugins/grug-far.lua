return {
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        windowCreationCommand = '.15split',

        keymaps = {
          replace = { n = '<leader>r' },
          qflist = { n = '<leader>q' },
          syncLocations = { n = '<leader>s' },
          syncLine = { n = '<leader>l' },
          close = { n = '<leader>c' },
          historyOpen = { n = '<leader>t' },
          historyAdd = { n = '<leader>a' },
          refresh = { n = '<leader>f' },
          gotoLocation = { n = '<enter>' },
          pickHistoryEntry = { n = '<enter>' },
          abort = { n = '<leader>b' },
        },
      })
    end,

    keys = {
      {
        '<leader>r',
        '<cmd>GrugFar<cr>',
        desc = 'Search and Replace',
      },
    },
  },
}
