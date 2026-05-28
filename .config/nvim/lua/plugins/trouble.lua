-- better diagnostics list and others
return {
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tt',
        '<cmd>Trouble diagnostics toggle focus=true<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>te',
        '<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>',
        desc = 'Errors (Trouble)',
      },
      -- {
      --   "<leader>xX",
      --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      --   desc = "Buffer Diagnostics (Trouble)",
      -- },
      {
        '<leader>ts',
        '<cmd>Trouble symbols toggle focus=false win.positoin=right<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>tq',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
