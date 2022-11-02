local M  = {}

function M.setup()
  require("glow").setup({
    -- glow_path = "", -- will be filled automatically with your glow bin in $PATH, if any
    -- install_path = "~/.local/bin", -- default path for installing glow binary
    border = "shadow", -- floating window border config
    style = "dark", --"dark|light", -- filled automatically with your current editor background, you can override using glow json style
    pager = false, --true|false
    width = 80,
  })
end

return M
