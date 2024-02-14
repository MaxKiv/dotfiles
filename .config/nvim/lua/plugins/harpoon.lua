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
      {
        "hq",
        [[<cmd>lua if jit.os == "Windows" then require("harpoon.term").gotoTerminal(1) else require("harpoon.tmux").gotoTerminal(1) end <CR>]],
        desc = "Goto terminal"
      },
      {
        "hw",
        [[<cmd>lua if jit.os == "Windows" then require("harpoon.term").gotoTerminal(2) else require("harpoon.tmux").gotoTerminal(2) end <CR>]],
        desc = "Goto terminal"
      },
      {
        "he",
        [[<cmd>lua if jit.os == "Windows" then require("harpoon.term").gotoTerminal(3) else require("harpoon.tmux").gotoTerminal(3) end <CR>]],
        desc = "Goto terminal"
      },
    }
  },
}
