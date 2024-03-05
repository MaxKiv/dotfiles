local map = vim.keymap.set

map("v", "<", "<gv", { desc = "reselect after indenting" })
map("v", ">", ">gv", { desc = "reselect after indenting" })

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { desc = "keep paste buffer" })
map("n", "s", 'viwP', { desc = "Paste over word" })
map("v", "s", 'P', { desc = "Paste over word" })

-- Move to next blank line without messing with jumplist
map("n", "<A-j>", "g'}", { desc = "paragraph jump  w/o jumplist" })
map("n", "<A-k>", "g'{", { desc = "paragraph jump  w/o jumplist" })

-- exit  terminal mode
vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])
