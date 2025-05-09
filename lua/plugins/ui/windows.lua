-- Window appearance and separator configuration
return {
  -- Add a separator for Window/Split boundaries
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Add visual separator for windows
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Set better vertical split styling
          vim.cmd([[highlight WinSeparator guibg=NONE guifg=#3b4261]])
          
          -- Special border styling for Ghostty terminal
          if vim.env.TERM_PROGRAM == "ghostty" then
            -- Add border color adjustments for better Ghostty integration
            vim.cmd([[highlight VertSplit guifg=#3b4261 guibg=NONE]])
            vim.cmd([[highlight WinSeparator guifg=#3b4261 guibg=NONE]])
            
            -- Better endpoint handling
            vim.cmd([[highlight EndOfBuffer guibg=NONE]])
          end
        end
      })
      
      -- Set vertical split character
      vim.opt.fillchars:append({
        horiz = '━',
        horizup = '┻',
        horizdown = '┳',
        vert = '┃',
        vertleft = '┫',
        vertright = '┣',
        verthoriz = '╋',
      })
    end,
  },
}