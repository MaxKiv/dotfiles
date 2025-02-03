-- Plugin to toggle split/joining lists of items arguments, tables, etc
return {
  {
    'echasnovski/mini.statusline',
    version = '*',
    config = function()
      require('mini.statusline').setup()
    end,
  },
}
