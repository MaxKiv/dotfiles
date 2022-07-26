local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true}

-- Escape to normal using jk
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Reselect last selection after indenting in visual mode
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffers
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Move to next blank line without messing with jumplist
keymap("n", "<A-j>", "g'}", default_opts)
keymap("n", "<A-k>", "g'{", default_opts)

local function nkeymap(lh, rh)
  keymap("n", lh, rh, default_opts)
end

-- Telescope
-- nkeymap('<leaderff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
-- nkeymap('<leaderfg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
-- nkeymap('<leaderfb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
-- nkeymap('<leaderfh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- LSP maps
nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

