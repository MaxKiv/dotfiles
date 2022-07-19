local M = {}

function M.setup()
   require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
    indent = {
      enable = true,
    }
  }

  -- Options
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  
end

return M
