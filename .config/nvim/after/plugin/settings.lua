-- Find OS
local operating_system
if (package.config:sub(1, 1) == "/") then
  operating_system = "Unix"
else
  operating_system = "Shit"
end

local api = vim.api
local g = vim.g
local opt = vim.opt
HOME = os.getenv("HOME")

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- General
opt.errorbells = false
opt.wrap = false
g.cmdheigth = 2
opt.updatetime = 100
opt.termguicolors = true
opt.timeoutlen = 500
vim.wo.colorcolumn = 80

-- Searching
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Scrolling
opt.scrolloff = 999

-- Gutter
opt.relativenumber = true
opt.nu = true
opt.signcolumn = "yes"

-- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- No large files
opt.colorcolumn = "80"

-- Please yes
if vim.loop.os_uname().sysname ~= "Windows_NT" then
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
  vim.opt.undofile = true
end

-- Please no
opt.swapfile = false
opt.backup = false
opt.modelines = 0

-- Please no auto comment
vim.api.nvim_exec([[autocmd BufNewFile,BufReadPost * setlocal formatoptions-=o]], false)

-- vim.cmd [[
-- " gray
-- highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
-- " blue
-- highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
-- highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
-- " light blue
-- highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- highlight! link CmpItemKindInterface CmpItemKindVariable
-- highlight! link CmpItemKindText CmpItemKindVariable
-- " pink
-- highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- highlight! link CmpItemKindMethod CmpItemKindFunction
-- " front
-- highlight! CmpItemKindKeyword guibg=NONE guifg=#b8bb26
-- highlight! link CmpItemKindProperty CmpItemKindKeyword
-- highlight! link CmpItemKindUnit CmpItemKindKeyword
-- ]]

-- Use system clipboard
if not operating_system == "Unix" then
  opt.clipboard = "unnamed"
else
  opt.clipboard = "unnamedplus"
end

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
