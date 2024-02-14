return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "debugloop/telescope-undo.nvim",
      "ThePrimeagen/harpoon",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
          'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            height = vim.o.lines,
            width = vim.o.columns,
            prompt_position = "bottom",
            preview_height = 0.5,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", --  "smart_case", "ignore_case" or "respect_case"
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {
              -- extend mappings
              i = {
                ["<C-h>"] = require("telescope.actions").which_key,
                ["<C-Down>"] = require("telescope.actions").cycle_history_next,
                ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
                ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t" }),
              },
            },
          },
        }
      })
      require("telescope").load_extension("repo")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("fzf")
      -- require("telescope").load_extension("refactoring")
      require("telescope").load_extension("harpoon")
      -- require('telescope').load_extension('dap')
      require("telescope").load_extension("ui-select")
    end,
  }
}
