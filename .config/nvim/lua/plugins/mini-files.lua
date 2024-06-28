return {
  {
    'echasnovski/mini.files', version = '*',
    config = function()
      require("mini.files").setup({
        mappings = {
          close       = 'q',
          go_in       = 'l',
          go_in_plus  = 'L',
          go_out      = 'h',
          go_out_plus = 'H',
          reset       = '<BS>',
          reveal_cwd  = '@',
          show_help   = 'g?',
          synchronize = '<CR>',
          trim_left   = '<',
          trim_right  = '>',
        },
      })
    end,
    keys = {
      {
        "<CR>",
        "<cmd>lua MiniFiles.open()<cr>",
        desc = "open mini.files",
      },
    }
  },
}
