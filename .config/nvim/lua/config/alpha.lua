local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {
      [[HHHHHHHHH     HHHHHHHHH  iiii       KKKKKKKKK    KKKKKKK  iiii              d::::::d            d::::::d                 ]],
      [[H:::::::H     H:::::::H i::::i      K:::::::K    K:::::K i::::i             d::::::d            d::::::d                 ]],
      [[H:::::::H     H:::::::H  iiii       K:::::::K    K:::::K  iiii              d::::::d            d::::::d                 ]],
      [[HH::::::H     H::::::HH             K:::::::K   K::::::K                    d:::::d             d:::::d                  ]],
      [[  H:::::H     H:::::H  iiiiiii      KK::::::K  K:::::KKKiiiiiii     ddddddddd:::::d     ddddddddd:::::d    ooooooooooo   ]],
      [[  H:::::H     H:::::H  i:::::i        K:::::K K:::::K   i:::::i   dd::::::::::::::d   dd::::::::::::::d  oo:::::::::::oo ]],
      [[  H::::::HHHHH::::::H   i::::i        K::::::K:::::K     i::::i  d::::::::::::::::d  d::::::::::::::::d o:::::::::::::::o]],
      [[  H:::::::::::::::::H   i::::i        K:::::::::::K      i::::i d:::::::ddddd:::::d d:::::::ddddd:::::d o:::::ooooo:::::o]],
      [[  H:::::::::::::::::H   i::::i        K:::::::::::K      i::::i d::::::d    d:::::d d::::::d    d:::::d o::::o     o::::o]],
      [[  H::::::HHHHH::::::H   i::::i        K::::::K:::::K     i::::i d:::::d     d:::::d d:::::d     d:::::d o::::o     o::::o]],
      [[  H:::::H     H:::::H   i::::i        K:::::K K:::::K    i::::i d:::::d     d:::::d d:::::d     d:::::d o::::o     o::::o]],
      [[  H:::::H     H:::::H   i::::i      KK::::::K  K:::::KKK i::::i d:::::d     d:::::d d:::::d     d:::::d o::::o     o::::o]],
      [[HH::::::H     H::::::HHi::::::i     K:::::::K   K::::::Ki::::::id::::::ddddd::::::ddd::::::ddddd::::::ddo:::::ooooo:::::o]],
      [[H:::::::H     H:::::::Hi::::::i     K:::::::K    K:::::Ki::::::i d:::::::::::::::::d d:::::::::::::::::do:::::::::::::::o]],
      [[H:::::::H     H:::::::Hi::::::i     K:::::::K    K:::::Ki::::::i  d:::::::::ddd::::d  d:::::::::ddd::::d oo:::::::::::oo ]],
      [[HHHHHHHHH     HHHHHHHHHiiiiiiii     KKKKKKKKK    KKKKKKKiiiiiiii   ddddddddd   ddddd   ddddddddd   ddddd   ooooooooooo   ]],
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("t", "🔭 Telescopic Johnson", ":Telescope find_files <CR>"),
    dashboard.button("c", "  Configuration", ":Telescope find_files cwd=~/.config/nvim/<CR>"),
    dashboard.button("r", "  Recently used files"   , ":Telescope oldfiles<CR>"),
    -- dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
