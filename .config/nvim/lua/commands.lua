local function generate_sha256(input)
  local handle = io.popen("echo -n '" .. input .. "' | sha256sum")
  if not handle then
    return ''
  end

  local result = handle:read('*a')
  handle:close()
  -- Extract the first 8 characters of the hash
  local hash = result:match('^%w+')
  return hash:sub(1, 8)
end

local format_date = function(input_date)
  local date_str

  if vim.fn.has('win32') == 1 then
    date_str = vim.fn.systemlist(
      'powershell -Command "& {(Get-Date).AddDays(([int](New-TimeSpan -Start (Get-Date) -End (Get-Date "'
        .. input_date
        .. '")).Days)).ToString(\'yyyy-MM-dd\')}"'
    )[1]
  elseif vim.fn.has('mac') == 1 then
    date_str =
      vim.fn.systemlist("date -j -v'" .. input_date .. "' +%Y-%m-%d")[1]
  else
    date_str = vim.fn.systemlist("date -d '" .. input_date .. "' +%Y-%m-%d")[1]
  end

  return date_str
end

-- open daily note
vim.api.nvim_create_user_command('Today', function()
  local daily_dir = 'daily/'
  local date_str = os.date('%Y-%m-%d')
  local filename = daily_dir .. date_str .. '.md'

  -- Ensure the directory exists
  vim.fn.mkdir(daily_dir, 'p')

  -- Open the file in the current buffer
  vim.cmd('edit ' .. filename)
end, {})

-- open given note using system `date` command
-- SYNTAX:
-- tomorrow
-- yesterday
-- next Friday
-- last Monday
-- 2 weeks
-- 2 weeks from now
-- 3 days ago
-- 1 month
-- next year
vim.api.nvim_create_user_command('Daily', function(opts)
  local daily_dir = 'daily/'
  local input_date = opts.args ~= '' and opts.args or 'today'
  local date_str = format_date(input_date)

  local filename = daily_dir .. date_str .. '.md'

  -- Ensure the directory exists
  vim.fn.mkdir(daily_dir, 'p')

  -- Open the file in the current buffer
  vim.cmd('edit ' .. filename)
end, { nargs = '?' })

-- Custom Note taking command
vim.api.nvim_create_user_command('Note', function(opts)
  local dir = 'note/'
  local input_note_name = opts.args ~= '' and opts.args or ''

  local sha256 = generate_sha256(input_note_name)

  local date = format_date('today')

  local filename = dir .. sha256 .. '-' .. input_note_name .. '.md'

  -- Ensure the directory exists
  vim.fn.mkdir(dir, 'p')

  -- Open the file in the current buffer
  vim.cmd('edit ' .. filename)

  -- Write the header to the file
  local header = {
    '# ' .. input_note_name,
    '',
    date,
    '',
    '----',
  }

  -- Insert the header at the top of the file
  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end, { nargs = '?' })

-- Custom PasteImage command
vim.api.nvim_create_user_command('PasteImage', function()
  local note_path = vim.fn.expand('%:p')
  local vault_root = vim.fn.fnamemodify(note_path, ':h:h')

  local result = vim.fn.system({ 'paste-image', vault_root, note_path })

  if vim.v.shell_error ~= 0 then
    -- Even if shell_error is set, we might still have a valid link in the output
    -- depending on how the script handles errors. However, standard practice is to notify.
    vim.notify('PasteImage: ' .. vim.trim(result), vim.log.levels.ERROR)
    -- Optional: return early if you strictly want to stop on error,
    -- but the prompt implies we just want to parse the output regardless of warnings.
    -- If the command failed completely (no output), the logic below will handle it gracefully.
  end

  -- Split output by newlines
  local lines = vim.split(result, '\n')

  -- Filter lines: keep non-empty lines that do NOT start with '!' (ignoring warnings/errors)
  -- This assumes the valid markdown link does not start with '!'.
  local valid_lines = {}
  for _, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed ~= '' and trimmed:match('^!') then
      table.insert(valid_lines, trimmed)
    end
  end

  if #valid_lines == 0 then
    vim.notify(
      'PasteImage: No valid image link found in output.',
      vim.log.levels.ERROR
    )
    return
  end

  -- Take the last valid line
  local link = valid_lines[#valid_lines]

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ''

  -- Insert the link at the cursor position
  local new_line = line:sub(1, col) .. link .. line:sub(col + 1)
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })

  -- Move cursor to the end of the inserted link
  vim.api.nvim_win_set_cursor(0, { row, col + #link })
end, {})
