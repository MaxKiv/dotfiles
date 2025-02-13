return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'cljoly/telescope-repo.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      -- "nvim-telescope/telescope-dap.nvim",
      'debugloop/telescope-undo.nvim',
      'ThePrimeagen/harpoon',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      },
    },
    config = function()
      local telescope = require('telescope')
      local telescope_lga = require('telescope-live-grep-args.actions')

      -- Use this to open results in folke's trouble
      local open_with_trouble = require('trouble.sources.telescope').open
      -- Use this to add more results without clearing the trouble list
      local add_to_trouble = require('trouble.sources.telescope').add

      telescope.setup({

        -- :h telescope.layout
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            height = vim.o.lines,
            width = vim.o.columns,
            -- preview_height = 0.2,
            prompt_position = 'bottom',
          },
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case', --  "smart_case", "ignore_case" or "respect_case"
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {
              -- extend mappings
              i = {
                ['<C-k>'] = telescope_lga.quote_prompt(),
                ['<C-i>'] = telescope_lga.quote_prompt({
                  postfix = ' --no-ignore ',
                }),
                ['<C-e>'] = telescope_lga.quote_prompt({
                  postfix = ' -t ',
                }),
                ['<C-h>'] = telescope_lga.quote_prompt({
                  postfix = ' --hidden ',
                }),
                ['<c-t>'] = open_with_trouble,
                -- freeze the current list and start a fuzzy search in the frozen list
                ['<C-f>'] = 'to_fuzzy_refine',
              },
              n = {
                ['<c-t>'] = open_with_trouble,
              },
            },
          },
        },
      })

      telescope.load_extension('repo')
      telescope.load_extension('ui-select')
      telescope.load_extension('undo')
      telescope.load_extension('fzf')
      telescope.load_extension('harpoon')
      -- telescope.load_extension("dap")
    end,
  },
}
