-- Neovim config entry point, looks for modules in ./lua/

-- Load global functions
-- require("core.globals")

-- Plugin management via lazy
require("plugin_manager")

-- "Global" Keymappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Vim autocommands/autogroups
require("autocmd")

-- Global functions
require("functions")
