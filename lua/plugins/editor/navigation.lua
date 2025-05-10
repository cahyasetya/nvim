-- Navigation and file management plugins
return {
  -- Telescope moved to telescope.lua for consolidated configuration

  -- Easily jump between windows
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window right" },
    },
  },

  -- Better buffer navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add to Harpoon" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon Buffer 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon Buffer 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon Buffer 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon Buffer 4" })
    end,
  },
}