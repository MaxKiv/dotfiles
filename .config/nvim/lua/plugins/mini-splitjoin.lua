-- Plugin to toggle split/joining lists of items arguments, tables, etc
return {
  {
    'echasnovski/mini.splitjoin',
    version = '*',
    config = function()
      require('mini.splitjoin').setup()
    end,
  },
}
