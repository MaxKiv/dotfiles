return {
  {
    'retran/meow.yarn.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('meow.yarn').setup({
        window = {
          width = 0.8,
          height = 0.85,
          border = 'rounded',
          preview_height_ratio = 0.35,
        },
        icons = {
          loading = '',
          placeholder = '',
          animation_frames = {
            '⠋',
            '⠙',
            '⠹',
            '⠸',
            '⠼',
            '⠴',
            '⠦',
            '⠧',
            '⠇',
            '⠏',
          },
        },
        mappings = {
          jump = '<CR>',
          toggle = '<Tab>',
          expand = 'l',
          expand_alt = '<Right>',
          collapse = 'h',
          collapse_alt = '<Left>',
          quit = 'q',
        },
        expand_depth = 3,
        preview_context_lines = 10,
        animation_speed = 100,
        hierarchies = {
          type_hierarchy = {
            icons = {
              class = '󰌗',
              struct = '󰙅',
              interface = '󰌆',
              default = '',
            },
          },
          call_hierarchy = {
            icons = {
              method = '󰆧',
              func = '󰊕',
              variable = '',
              default = '',
            },
          },
        },
      })
    end,
  },
}
