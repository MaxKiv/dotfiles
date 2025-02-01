return {
  {
    'j-hui/fidget.nvim',
    lazy = false,
    priority = 1, -- make sure this loads after colorscheme
    opts = {
      notification = {
        window = {
          winblend = 0, -- Background color opacity in the notification window
        },
      },
    },
    config = function(_, opts)
      require('fidget').setup(opts)
      vim.api.nvim_set_hl(0, 'FidgetTitle', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'FidgetTask', { link = 'NormalFloat' })
    end,
  },
}
