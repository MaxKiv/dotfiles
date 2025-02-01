local map = vim.keymap.set

map('v', '<', '<gv', { desc = 'reselect after indenting' })
map('v', '>', '>gv', { desc = 'reselect after indenting' })

-- Paste over currently selected text without yanking it
map('v', 'p', '"_dP', { desc = 'keep paste buffer' })
map('n', 's', 'viwP', { desc = 'Paste over word' })
map('v', 's', 'P', { desc = 'Paste over word' })

-- Sensibly exit terminal mode
vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])
