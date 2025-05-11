return {
  -- Adds Git integration
  'NeogitOrg/neogit',
  dependencies = [
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  ],
  config = function()
    -- configure Neogit here if needed, e.g. settings, etc.
    -- require('neogit').setup {}

    -- Add keymap for Neogit status panel
    vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { desc = "Open Neogit status panel" })
  end,
}
