-- Cursor configuration - streamlined
return {
  -- SmoothCursor plugin with minimal configuration
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    opts = {
      autostart = true,
      disabled_filetypes = { "TelescopePrompt", "neo-tree", "dashboard" },
    },
    config = function(_, opts)
      -- The key fix: disable cursor line highlighting completely
      vim.opt.cursorline = false
      
      -- Set up minimal highlight groups with no backgrounds
      local colors = {
        blue = "#7aa2f7",
      }
      
      -- Set the main cursor highlight
      vim.api.nvim_set_hl(0, "Cursor", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.blue })
      
      require("smoothcursor").setup(opts)
    end,
  },
}
