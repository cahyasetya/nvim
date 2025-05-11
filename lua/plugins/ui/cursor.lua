-- Enhanced cursor styles and animations for Ghostty integration
return {

  
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