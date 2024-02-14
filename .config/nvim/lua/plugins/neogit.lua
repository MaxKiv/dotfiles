-- Git
return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      'sindrets/diffview.nvim'
    },
    cmd = {
      "Neogit",
    },

    config = function()
      local neogit = require("neogit")
      neogit.setup {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = false,
        -- Value used for `--sort` option for `git branch` command
        -- By default, branches will be sorted by commit date descending
        -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
        -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
        sort_branches = "-committerdate",
        disable_builtin_notifications = false,
        -- If enabled, use telescope for menu selection rather than vim.ui.select.
        -- Allows multi-select and some things that vim.ui.select doesn't.
        use_telescope = false,
        -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example
        -- below will use the native fzf sorter instead.
        telescope_sorter = function()
          return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        use_magit_keybindings = false,
        -- Change the default way of opening neogit
        kind = "tab",
        -- The time after which an output console is shown for slow running commands
        console_timeout = 2000,
        -- Automatically show console if a command takes more than console_timeout milliseconds
        auto_show_console = false,
        -- Persist the values of switches/options within and across sessions
        remember_settings = true,
        -- Scope persisted settings on a per-project basis
        use_per_project_settings = true,
        -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
        --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
        ignored_settings = {},
        -- Change the default way of opening the commit popup
        commit_popup = {
          kind = "split",
        },
        -- Change the default way of opening the preview buffer
        preview_buffer = {
          kind = "split",
        },
        -- Change the default way of opening popups
        popup = {
          kind = "split",
        },
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { ">", "v" },
          item = { ">", "v" },
          hunk = { "", "" },
        },
        integrations = {
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
          -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
          diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
          untracked = {
            folded = false
          },
          unstaged = {
            folded = false
          },
          staged = {
            folded = false
          },
          stashes = {
            folded = true
          },
          unpulled = {
            folded = true
          },
          unmerged = {
            folded = false
          },
          recent = {
            folded = true
          },
        },
        -- override/add mappings
        mappings = {
          -- modify status buffer mappings
          status = {
            -- Adds a mapping with "B" as key that does the "BranchPopup" command
            -- ["B"] = "BranchPopup",
            -- Removes the default mapping of "s"
            -- ["s"] = "",
          },
          -- Modify fuzzy-finder buffer mappings
          finder = {
            -- Binds <cr> to trigger select action
            ["<cr>"] = "select",
          },
          log_view = {
            ["<c-k>"] = "",
            ["<c-j>"] = "",
          },
        }
      }
    end
  },
}
