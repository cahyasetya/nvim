-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autosave configuration
vim.opt.updatetime = 1000  -- Set updatetime to 1000ms (1 second)

-- Autosave when text changes or losing focus
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "FocusLost" }, {
	pattern = "*",
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
			vim.api.nvim_command('silent! write')
		end
	end
})
