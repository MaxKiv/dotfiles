-- Plugin to toggle split/joining lists of items arguments, tables, etc
return {
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup()
    end,
  },
}
