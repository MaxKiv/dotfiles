return {
  -- A task runner and job management plugin for Neovim
  {
    'stevearc/overseer.nvim',
    opts = {
      -- We patch dap later, when we setup dap
      dap = false,
      templates = { 'builtin', 'user.c_build' },
    },
  },
}
