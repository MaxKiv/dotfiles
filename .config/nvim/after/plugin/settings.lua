-- Find OS
local operating_system
if(package.config:sub(1,1) == "/") then 
	operating_system = "Unix"
else
	operating_system = "Shit"
end

local api = vim.api
local g = vim.g
local opt = vim.opt
HOME = os.getenv("HOME")

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true})
g.mapleader = " "
g.maplocalleader = " "

-- General
opt.errorbells = false
opt.wrap = false
g.cmdheigth = 2
opt.updatetime = 100
opt.termguicolors = true
opt.timeoutlen = 500

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
