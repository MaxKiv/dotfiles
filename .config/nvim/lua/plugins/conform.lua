-- plugin to manage formatters
-- https://github.com/stevearc/conform.nvim
return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = function(bufnr)
          if
            require('conform').get_formatter_info('ruff_format', bufnr).available
          then
            return {
              'ruff_organize_imports',
              'ruff_format',
              'ruff_fix',
            }
          else
            return { 'isort', 'black' }
          end
        end,
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { 'rustfmt', lsp_format = 'fallback' },
        -- Conform will run the first available formatter
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        haskell = { 'ormolu' },
        nix = { 'alejandra' },
        text = nil,
        -- Use the "*" filetype to run formatters on all filetypes.
        -- Spelling checker
        -- ['*'] = { 'codespell' },
        -- TODO make this work and delete autocmd below
        -- ["justfile"] = { "just" }
      },

      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      -- This works with the FormatEnable and FormatDisable user commands
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,

      -- If this is set, Conform will run the formatter asynchronously after save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_after_save = {
        lsp_format = 'fallback',
      },
    })

    -- Make gq use conform
    -- Set formatexpr for everything except .txt files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(args)
        if vim.bo[args.buf].filetype ~= 'text' then
          vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        else
          vim.o.formatexpr = ''
        end
      end,
    })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    -- TODO: Remove this when justfile fmt is fixed in conform
    local augroup = vim.api.nvim_create_augroup('user', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Check justfile format on save',
      group = augroup,
      pattern = { '*justfile', '*.just' },
      -- command = "!just --unstable --fmt --justfile '%'",
      callback = function()
        -- Run black on the current file
        vim.cmd('silent !just --unstable --fmt')
        -- Refresh the file in Neovim after formatting
        vim.cmd('edit!')
      end,
    })
  end,
}
