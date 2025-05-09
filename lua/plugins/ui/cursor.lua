-- Enhanced cursor styles and animations for Ghostty integration
return {
  -- Smooth cursor movement with animations
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    opts = {
      autostart = true,
      cursor = "",
      texthl = "SmoothCursor",
      linehl = nil,
      type = "exp",
      fancy = {
        enable = true,
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "", texthl = "SmoothCursorRed" },
          { cursor = "", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".", texthl = "SmoothCursorBlue" },
          { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      flyin_effect = nil,
      speed = 25,
      intervals = 35,
      priority = 10,
      timeout = 3000,
      threshold = 3,
      disable_float_win = false,
      enabled_filetypes = nil,
      disabled_filetypes = { "TelescopePrompt", "neo-tree", "dashboard" },
    },
    config = function(_, opts)
      local has_ghostty = vim.env.TERM_PROGRAM == "ghostty"
      
      -- Don't enable fancy effects in Ghostty by default
      if has_ghostty then
        opts.fancy.enable = false
      end

      -- Setup cursor colors
      local colors = {
        red = "#f7768e",
        orange = "#ff9e64",
        yellow = "#e0af68",
        green = "#9ece6a",
        aqua = "#7dcfff", 
        blue = "#7aa2f7",
        purple = "#bb9af7",
      }
      
      -- Define highlight groups for smooth cursor
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.blue, bg = colors.blue, blend = 50 })
      vim.api.nvim_set_hl(0, "SmoothCursorRed", { fg = colors.red })
      vim.api.nvim_set_hl(0, "SmoothCursorOrange", { fg = colors.orange })
      vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "SmoothCursorGreen", { fg = colors.green })
      vim.api.nvim_set_hl(0, "SmoothCursorAqua", { fg = colors.aqua })
      vim.api.nvim_set_hl(0, "SmoothCursorBlue", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "SmoothCursorPurple", { fg = colors.purple })
      
      require("smoothcursor").setup(opts)
      
      -- Create command to toggle fancy cursor effects
      vim.api.nvim_create_user_command("ToggleFancyCursor", function()
        local smooth_cursor = require("smoothcursor")
        local config = require("smoothcursor.config")
        
        config.fancy.enable = not config.fancy.enable
        
        smooth_cursor.stop()
        smooth_cursor.setup(config)
        smooth_cursor.start()
        
        vim.notify("Fancy cursor " .. (config.fancy.enable and "enabled" or "disabled"))
      end, {})
      
      -- Map key to toggle fancy cursor
      vim.keymap.set("n", "<leader>uc", "<cmd>ToggleFancyCursor<CR>", { desc = "Toggle fancy cursor effects" })
    end,
  },
  
  -- Different cursor shapes for different modes
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Set up cursor styles based on mode
      -- These are optimized for Ghostty terminal
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Set cursor shape based on mode
        vim.opt.guicursor = table.concat({
          "n-v:block-Cursor/lCursor-blinkwait10-blinkon20-blinkoff20",
          "i-c-ci-ve:ver25-Cursor/lCursor-blinkwait10-blinkon20-blinkoff20",
          "r-cr:hor20-Cursor/lCursor",
          "o:hor50-Cursor",
          "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
          "sm:block-blinkwait175-blinkoff150-blinkon175",
        }, ",")
        
        -- Set up cursor color transitions and highlight groups
        vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*",
          callback = function()
            local current_mode = vim.fn.mode()
            if current_mode == "n" then
              vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#7aa2f7" })
            elseif current_mode == "i" then
              vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#9ece6a" })
            elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
              vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#f7768e" })
            elseif current_mode == "c" then
              vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#e0af68" })
            elseif current_mode == "r" or current_mode == "R" then
              vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#bb9af7" })
            end
          end,
        })
        
        -- Initialize cursor color for normal mode
        vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#7aa2f7" })
      end
    end,
  },
}