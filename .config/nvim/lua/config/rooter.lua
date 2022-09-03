-- https://github.com/notjedi/nvim-rooter.lua
-- :Rooter -> manually set current working directory to root
-- :RooterToggle -> switch between root and current directory

local M = {}

function M.setup()
  local rooter = require("nvim-rooter").setup({
    update_cwd = true,

    update_focused_file = {
      enable = true,
      update_cwd = true
    },

    rooter_patterns = { '.git', '.hg', '.svn', '.config' },

    trigger_patterns = { '*' }, -- glob file pattern like *.cpp

    manual = false, -- enable for automatic cd to root, :Rooter for manual use
  })
end

return M
