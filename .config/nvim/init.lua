-- init.lua neovim config
local verbose = true

-- source lua files
local luafiles = {
  -- settings = false,
  -- keymaps = false,
  plugins = false,
}
for luafile, _ in pairs(luafiles) do
  local err
  -- luafiles[luafile], err = pcall(require, tostring(luafile))
  luafiles[luafile], err = pcall(require(tostring(luafile)).setup, "")
  if verbose then
    if not luafiles[luafile] then
      print(luafile .. " not sourced correctly: " .. err)
    else
      print(luafile .. " sources correctly")
    end
  end
end

