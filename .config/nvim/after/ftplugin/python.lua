-- -- Create a group for the autocmd to avoid duplicates if the script is reloaded
-- local black_format_grp = vim.api.nvim_create_augroup("BlackFormatOnSave", { clear = true })
--
-- -- Create the autocmd
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.py",  -- Only trigger for Python files
--   callback = function()
--     -- Run black on the current file
--     vim.cmd("silent !black --quiet %")
--     -- Refresh the file in Neovim after formatting
--     vim.cmd("edit!")
--   end,
--   group = black_format_grp,  -- Assign to the group
-- })
