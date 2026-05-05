local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('keep', opts, {
    -- non-recursive map
    noremap = true,
    -- do not echo to command line
    silent = true,
    -- execute as soon as match found, do not wait for other keys
    nowait = true,
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Quit
M.map('n', '<leader>qq', '<cmd>wqa!<cr>', { desc = 'Quit all' })

-- Better indenting
M.map('v', '<', '<gv', { desc = 'reselect after indenting' })
M.map('v', '>', '>gv', { desc = 'reselect after indenting' })

-- Paste over currently selected text without yanking it
M.map('v', 'p', '"_dP', { desc = 'keep paste buffer' })

-- Move Lines
M.map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
M.map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
M.map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
M.map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
M.map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
M.map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Terminal -------------------------------------
M.map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
M.map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
M.map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
M.map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
M.map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })
M.map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

-- Always search forward with n, always search backward with N,
-- regardless of starting method - / or ?
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
M.map(
  'n',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Next search result' }
)
M.map(
  'x',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Next search result' }
)
M.map(
  'o',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Next search result' }
)
M.map(
  'n',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Prev search result' }
)
M.map(
  'x',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Prev search result' }
)
M.map(
  'o',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Prev search result' }
)

return M
