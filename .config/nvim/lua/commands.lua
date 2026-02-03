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
