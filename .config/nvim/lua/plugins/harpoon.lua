-- Spearfishing
return {
  { "ThePrimeagen/harpoon",
    requires = { "nvim-lua/plenary.nvim" },
    keys = {
      {"hm",[[<cmd>lua require("harpoon.mark").add_file()<Cr>]], desc = "Mark Buffer" },
      {"hf",[[<cmd>lua require("harpoon.ui").toggle_quick_menu()<Cr>]], desc = "View Marks" },
    },
  },
}
