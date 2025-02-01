local cmd = vim.cmdfunct
local fn = vim.fn

local M = {}

local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'

--- Merge extended options with a default table of options
--- Stolen from astroNvim, thanks! 😘
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
M.extend_tbl = function(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend('force', default, opts) or opts
end

-- Join all paragraphs
M.join_paragraphs = function()
  -- Get the current buffer
  local buf = vim.api.nvim_get_current_buf()

  -- Get all lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Placeholder for the new lines
  local new_lines = {}
  local paragraph = {}

  for _, line in ipairs(lines) do
    if line == '' then
      if #paragraph > 0 then
        table.insert(new_lines, table.concat(paragraph, ' '))
        paragraph = {}
      end
      table.insert(new_lines, '')
    else
      table.insert(paragraph, line)
    end
  end

  if #paragraph > 0 then
    table.insert(new_lines, table.concat(paragraph, ' '))
  end

  -- Replace buffer content with new_lines
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
end

M.open_current_file_in_file_explorer = function()
  if is_windows then
    vim.cmd([[silent !start %:p:h]])
  else
    vim.cmd([[silent !xdg-open %:p:h]])
  end
end

M.open_project_root_in_file_explorer = function()
  if is_windows then
    vim.cmd([[silent !start .]])
  else
    vim.cmd([[silent !xdg-open .]])
  end
end

M.open_project_root_in_terminal = function()
  if is_windows then
    vim.cmd([[silent !start alacritty --working-directory .]])
  else
    vim.cmd([[silent !alacritty --working-directory .]])
  end
end

M.toggle_qf = function()
  local windows = fn.getwininfo()
  local qf_exists = false
  for _, win in pairs(windows) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    cmd('cclose')
    return
  end
  if M.isNotEmpty(fn.getqflist()) then
    cmd('copen')
  end
end

M.toggle_colorcolumn = function()
  local value = vim.api.nvim_get_option_value('colorcolumn', {})
  if value == '' then
    M.notify('Enable colocolumn', 1, 'functions.lua')
    vim.api.nvim_set_option_value('colorcolumn', '79', {})
  else
    M.notify('Disable colocolumn', 1, 'functions.lua')
    vim.api.nvim_set_option_value('colorcolumn', '', {})
  end
end

M.copy_file_path = function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end

M.copy_file_name = function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
end

M.copy_file_path_from_root = function()
  vim.fn.setreg('+', vim.fn.fnamemodify(vim.fn.expand('%'), ':p:.'))
end

M.clipboard_switch_brackets = function()
  local sub, count = string.gsub(vim.fn.getreg('+'), [[\]], [[/]])
  if count > 0 then
    vim.fn.setreg('+', sub)
  else
    local sub, _ = string.gsub(vim.fn.getreg('+'), [[/]], [[\]])
    vim.fn.setreg('+', sub)
  end
end

-- Function to accept the first spelling suggestion for the hovered word
M.accept_first_spelling_suggestion = function()
  -- Get the word under the cursor
  local word = vim.fn.expand('<cword>')

  -- Get spelling suggestions for the word
  local suggestions = vim.fn.spellsuggest(word)

  if #suggestions > 0 then
    -- Replace the current word with the first suggestion
    vim.cmd('normal! ciw' .. suggestions[1])
  else
    print('No spelling suggestions available')
  end
end

-- TODO this could be cleaner
M.diff_is_toggled = false
M.toggle_diff_splits = function()
  local neo_tree_loaded, _ = pcall(require, 'neo-tree')
  if M.diff_is_toggled then
    if neo_tree_loaded then
      vim.cmd([[NeoTreeClose]])
    end
    vim.cmd([[windo diffthis]])
  else
    vim.cmd([[diffoff!]])
  end
  M.diff_is_toggled = not M.diff_is_toggled
end

-- Execute a default (non-interactive) shell command and capture its output
-- into a Lua variable
M.execute_command = function(command)
  local handle = io.popen(command)
  local result = handle:read('*a')
  handle:close()
  return result
end

-- Execute a shell command and capture its output into a Lua variable
M.execute_shell_command = function(command)
  local output = vim.fn.systemlist(command)
  return output
end

-- Get dotfiles directory on this system
local output = M.execute_shell_command([[
  bash -i -c "dot rev-parse --show-toplevel"
]])
M.dotfiles_dir = output[#output] or '$HOME/.config/nvim'

M.running_nixos = function()
  local uv = vim.loop
  local nixos_file = '/etc/NIXOS'
  local stat = uv.fs_stat(nixos_file)
  return stat and stat.type == 'file'
end

return M
