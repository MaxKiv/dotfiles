return {
  {

    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      local gps = require "nvim-gps"

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          -- theme = "solarized",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            { "filename" },
            {
              gps.get_location,
              cond = gps.is_available,
              color = { fg = "ffaf00ff" },
            },
          },
          lualine_x = { "filetype", "fileformat" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end
  },
}