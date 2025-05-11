-- UI configuration for Neovim
local M = {}

-- Function to set common UI options
function M.setup()
  -- Always show status line
  vim.opt.laststatus = 3
  
  -- Show line numbers
  vim.opt.number = true
  vim.opt.relativenumber = true
  
  -- Enable true colors
  vim.opt.termguicolors = true
  
  -- No wrapping
  vim.opt.wrap = false
  
  -- Disable cursor line highlighting completely
  vim.opt.cursorline = false
  
  -- Show signcolumn (for git signs, etc)
  vim.opt.signcolumn = "yes"

  -- Shorter updatetime for better UX
  vim.opt.updatetime = 250
  
  -- Force status line to always be visible
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.opt.laststatus = 3
    end,
  })
  
  -- Force status line redraw on window focus
  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      vim.cmd("redrawstatus")
    end,
  })
  
  -- Ghostty-specific UI adjustments
  if vim.env.TERM_PROGRAM == "ghostty" then
    -- Ensure statusline remains visible with transparency
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Make statusline background slightly visible
        vim.cmd([[highlight StatusLine guibg=#1a1b26 blend=10]])
        vim.cmd([[highlight StatusLineNC guibg=#1a1b26 blend=20]])
        
        -- Ensure WinSeparator is visible
        vim.cmd([[highlight WinSeparator guibg=NONE guifg=#3b4261]])
      end,
    })
  end
end

return M