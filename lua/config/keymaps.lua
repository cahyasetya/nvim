-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "<C-A-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- Neo-tree file explorer keybindings are now handled in config/explorer.lua

-- Bind gs to LSP's document symbol to list functions in the file
vim.keymap.set('n', 'gs', function()
  vim.lsp.buf.document_symbol()
end, { noremap = true, silent = true, desc = "Get all functions in the current file" })

-- Ghostty specific keymaps
if vim.env.TERM_PROGRAM == "ghostty" then
  -- Quick access to terminal
  vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
  vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
  vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })

  -- Navigation in terminal mode
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move to left window" })
  vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move to lower window" })
  vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Move to upper window" })
  vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move to right window" })
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit terminal mode" })
end

-- Transparency toggle
vim.keymap.set("n", "<leader>ut", "<cmd>ToggleTransparency<CR>", { desc = "Toggle transparency" })

-- Fast window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

