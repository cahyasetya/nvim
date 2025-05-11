-- Custom navigation keymaps
-- gb: Go Back to previous cursor location (across files)
-- gn: Go Next to next cursor location (across files)
vim.keymap.set("n", "gb", "<C-o>", { noremap = true, silent = true, desc = "Go back to previous cursor location" })
vim.keymap.set("n", "gn", "<C-i>", { noremap = true, silent = true, desc = "Go forward to next cursor location" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "<C-A-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- Neo-tree file explorer keybindings are now handled in config/explorer.lua

-- Bind gs to Telescope's document symbol finder for better UI
vim.keymap.set('n', 'gs', function()
  require('telescope.builtin').lsp_document_symbols({
    symbols = {
      'function', 'method', 'class', 'struct', 'enum',
      'interface', 'module', 'namespace', 'package', 'property'
    }
  })
end, { noremap = true, silent = true, desc = "Browse document symbols via Telescope" })

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

-- Toggle centered cursor (for relative number navigation)
local centered_cursor = false
vim.keymap.set("n", "<leader>uc", function()
  centered_cursor = not centered_cursor
  if centered_cursor then
    vim.opt.scrolloff = 999  -- Center cursor
    vim.notify("Centered cursor enabled")
  else
    vim.opt.scrolloff = 8    -- Normal scrolling
    vim.notify("Normal scrolling enabled")
  end
end, { desc = "Toggle centered cursor" })

-- Fast window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Folding shortcuts
vim.keymap.set("n", "<leader>zf", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "<leader>zF", "zA", { desc = "Toggle all folds under cursor" })
vim.keymap.set("n", "<leader>zc", "zc", { desc = "Close fold under cursor" })
vim.keymap.set("n", "<leader>zo", "zo", { desc = "Open fold under cursor" })
vim.keymap.set("n", "<leader>zC", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "<leader>zO", "zR", { desc = "Open all folds" })

