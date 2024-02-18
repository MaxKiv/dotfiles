return {
  { 
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      scope = { enabled =false, show_start = false, show_end = false },
      exclude = {
        buftypes = {
          "nofile",
          "terminal",
        },
        filetypes = {
          "help",
          "startify",
          "aerial",
          "alpha",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "neo-tree",
          "Trouble",
        },
      },
    }
  }
}
