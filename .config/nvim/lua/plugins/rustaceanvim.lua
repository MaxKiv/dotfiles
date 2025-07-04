return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    local cfg = require('rustaceanvim.config')

    -- These variables are required to configure the codelldb debugger for use with rustaceanvim
    local extension_path = nil
    local codelldb_path = nil
    local liblldb_path = nil

    -- On NixOS codelldb's path should be exposed in this ENV
    if require('functions').running_nixos() then
      extension_path = vim.fn.getenv('NVIM_CODELLDB_PATH')
      if
        not extension_path
        or extension_path == vim.NIL
        or extension_path == ''
      then
        -- Provide a fallback or error if NVIM_CODELLDB_PATH is not set
        vim.notify(
          'Running NixOS but NVIM_CODELLDB_PATH is not set. Please configure the environment variable.',
          vim.log.levels.ERROR
        )
        return
      end
      codelldb_path = extension_path .. '/adapter/codelldb'
      liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
    else -- Running some other OS, find codelldb through usual method
      -- Update this path
      extension_path = vim.env.HOME
        .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
      codelldb_path = extension_path .. 'adapter/codelldb'
      liblldb_path = extension_path .. 'lldb/lib/liblldb'

      -- The path is different on Windows
      local this_os = vim.uv.os_uname().sysname
      if this_os:find('Windows') then
        codelldb_path = extension_path .. 'adapter\\codelldb.exe'
        liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
      else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path
          .. (this_os == 'Linux' and '.so' or '.dylib')
      end
    end

    vim.g.rustaceanvim = {
      tools = {
        --- options same as lsp hover
        ---@see vim.lsp.util.open_floating_preview
        ---@see vim.api.nvim_open_win
        ---@type table Options applied to floating windows.
        float_win_config = {
          --- whether the window gets automatically focused
          --- default: false
          ---@type boolean
          auto_focus = true,

          --- whether splits opened from floating preview are vertical
          --- default: horizontal
          ---@type 'horizontal' | 'vertical'
          open_split = 'horizontal',
        },
      },

      server = {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true)
        end,
      },

      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    }
  end,
}
