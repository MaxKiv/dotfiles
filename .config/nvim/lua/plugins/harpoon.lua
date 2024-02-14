-- Spearfishing
return {
  { "ThePrimeagen/harpoon",
    requires = { "nvim-lua/plenary.nvim" },
    keys = {
      {"hm",[[<cmd>lua require("harpoon.mark").add_file()<Cr>]], desc = "Mark Buffer" },
      {"hf",[[<cmd>lua require("harpoon.ui").toggle_quick_menu()<Cr>]], desc = "View Marks" },
      {"ha",[[<cmd>lua require("harpoon.ui").nav_file(1)<Cr>]], desc = "Goto 1" },
      {"hs",[[<cmd>lua require("harpoon.ui").nav_file(2)<Cr>]], desc = "Goto 2" },
      {"hd",[[<cmd>lua require("harpoon.ui").nav_file(3)<Cr>]], desc = "Goto 3" },
      {"ht",[[<cmd>lua require("harpoon.tmux").gotoTerminal(1)<Cr>]], desc = "Goto terminal" },
    }
  },
}
