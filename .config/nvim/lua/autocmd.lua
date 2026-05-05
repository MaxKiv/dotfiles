local api = vim.api

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
local TrimWhiteSpaceGrp =
  api.nvim_create_augroup('TrimWhiteSpaceGrp', { clear = true })
api.nvim_create_autocmd('BufWritePre', {
  pattern = { '!*.md' },
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

-- Reset formatoptions after opening a buffer, make sure no auto comment on 'o'
api.nvim_create_autocmd(
  { 'BufReadPost', 'BufEnter' },
  { command = [[set formatoptions=tcrqnj]] }
)

-- places cursor at last location when opening a buffer
vim.api.nvim_create_autocmd(
  -- when starting to edit a buffer
  'BufReadPost',
  {
    callback = function()
      -- (row, col) of last known cursor position
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      -- number of lines in buffer
      local lcount = vim.api.nvim_buf_line_count(0)
      -- if mark is valid, move to it
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  }
)
-- windows to close with "q"
api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'startuptime',
    'qf',
    'fugitive',
    'null-ls-info',
    'dap-float',
    'help',
    'lspinfo',
    'checkhealth',
    'man',
  },
  callback = function(event)
    vim.keymap.set('n', 'q', '<cmd>bd<cr>', {
      buffer = event.buf,
      -- non-recursive map
      noremap = true,
      -- do not echo to command line
      silent = true,
      -- execute as soon as match found, do not wait for other keys
      nowait = true,
    })
  end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.tex' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en,nl'
    vim.opt_local.textwidth = 80
  end,
})

-- api.nvim_create_autocmd(
--   { "BufRead", "BufNewFile" },
--   {
--     pattern = { "*.nix" },
--     callback = function()
--       -- set current buffer formatexpr to nixpkgs-fmt
--       -- api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
--       -- TODO get the nixpkgs-fmt value from the nix lsp
--       api.nvim_buf_set_option(0, "formatprg", "alejandra --quiet")
--     end,
--   }
-- )

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd(
  { 'FocusGained', 'TermClose', 'TermLeave' },
  { command = 'checktime' }
)

-- Wrap and spell for markdown and git commits
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
  end,
})

-- Set filetype groovy for JenkinsFiles
local jenkins_grp = vim.api.nvim_create_augroup('Jenkins', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'JenkinsFile' },
  callback = function()
    vim.bo.filetype = 'groovy' -- Set the filetype to groovy
  end,
  group = jenkins_grp,
})

local format_sync_grp = vim.api.nvim_create_augroup('Format', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rs',
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

-- resizes splits if window got resized
vim.api.nvim_create_autocmd(
  -- after Vim window was resized
  'VimResized',
  {
    callback = function()
      -- for each tab, make windows equal
      vim.cmd('tabdo wincmd =')
    end,
  }
)
