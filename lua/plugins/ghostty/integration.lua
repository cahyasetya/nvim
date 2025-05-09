-- Ghostty-specific integration features
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Set up better terminal behavior with Ghostty
        
        -- Terminal colors
        vim.g.terminal_color_0 = "#1a1b26"  -- Black
        vim.g.terminal_color_1 = "#f7768e"  -- Red
        vim.g.terminal_color_2 = "#9ece6a"  -- Green
        vim.g.terminal_color_3 = "#e0af68"  -- Yellow
        vim.g.terminal_color_4 = "#7aa2f7"  -- Blue
        vim.g.terminal_color_5 = "#bb9af7"  -- Magenta
        vim.g.terminal_color_6 = "#7dcfff"  -- Cyan
        vim.g.terminal_color_7 = "#a9b1d6"  -- White
        vim.g.terminal_color_8 = "#414868"  -- Bright Black
        vim.g.terminal_color_9 = "#f7768e"  -- Bright Red
        vim.g.terminal_color_10 = "#9ece6a" -- Bright Green
        vim.g.terminal_color_11 = "#e0af68" -- Bright Yellow
        vim.g.terminal_color_12 = "#7aa2f7" -- Bright Blue
        vim.g.terminal_color_13 = "#bb9af7" -- Bright Magenta
        vim.g.terminal_color_14 = "#7dcfff" -- Bright Cyan
        vim.g.terminal_color_15 = "#c0caf5" -- Bright White
        
        -- Set TERM properly for Ghostty
        vim.env.TERM = "xterm-256color"
        
        -- Create Ghostty-specific command to show custom options
        vim.api.nvim_create_user_command("GhosttyOptions", function()
          local lines = {
            "Ghostty Terminal Integration Options:",
            "------------------------------------",
            "",
            "Keybindings:",
            "  <leader>ut  - Toggle transparency",
            "  <leader>uc  - Toggle fancy cursor effects",
            "  <leader>t   - Open floating terminal",
            "  <leader>tv  - Open vertical terminal",
            "  <leader>th  - Open horizontal terminal",
            "  <C-\\>      - Toggle terminal",
            "",
            "Commands:",
            "  :GhosttyWelcome     - Show welcome screen",
            "  :ToggleTransparency - Toggle background transparency",
            "  :ToggleFancyCursor  - Toggle cursor effects",
            "",
            "Status:",
            "  Transparency: " .. (vim.g.transparent_enabled and "Enabled" or "Disabled"),
            "  Fancy Cursor: " .. (vim.g.fancy_cursor_enabled and "Enabled" or "Disabled"),
          }
          
          -- Create a floating window
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          
          local width = 60
          local height = #lines
          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            col = math.floor((vim.o.columns - width) / 2),
            row = math.floor((vim.o.lines - height) / 2),
            style = "minimal",
            border = "rounded",
          })
          
          -- Set buffer options
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
          vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
          
          -- Set buffer mappings
          vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
          
          -- Syntax highlighting
          vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:FloatBorder")
          
          -- Set filetype for custom highlighting
          vim.api.nvim_buf_set_option(buf, "filetype", "ghostty-options")
        end, {})
        
        -- Register the callback for detecting Ghostty updates
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.notify("Ghostty terminal integration active", vim.log.levels.INFO)
          end,
          once = true,
        })
      end
    end
  },
  
  -- Special handling for Ghostty terminal commands
  {
    "LazyVim/LazyVim",
    event = "VeryLazy",
    config = function()
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Create a help command for Ghostty integration
        vim.api.nvim_create_user_command("GhosttyHelp", function()
          vim.cmd([[help ghostty-integration]])
        end, {})
        
        -- Ensure the status line shows Ghostty information
        vim.g.ghostty_integration_active = true
      end
    end,
  },
}