-- Basic diagnostic configuration that won't cause errors
vim.diagnostic.config({
  signs = false, -- No signs in the sign column
  underline = true,
  virtual_text = false, -- Disable virtual text initially
  float = {
    border = "rounded",
  },
})

-- Organized Neovim Configuration for Ghostty
-- This configuration is organized into categories for better maintenance

-- Pre-load nvim-cmp to fix loading issues
pcall(function() require("config.fix-cmp-preload").setup() end)

-- Load core modules
require("config.lazy")    -- Plugin manager setup
require("config.keymaps") -- Keybindings
require("config.ui").setup() -- UI configuration

-- Basic editor settings
vim.o.tabstop = 2         -- Tab width
vim.o.shiftwidth = 2      -- Indentation width
vim.o.expandtab = true    -- Use spaces instead of tabs
vim.o.softtabstop = 2     -- Soft tab width
vim.o.smartindent = true  -- Smart auto-indenting

-- Disable lazyredraw to avoid Noice issues
vim.o.lazyredraw = false

-- Window separator characters
vim.opt.fillchars:append({
  horiz = '━',     -- Horizontal line
  horizup = '┻',   -- Horizontal line with up connector
  horizdown = '┳', -- Horizontal line with down connector
  vert = '┃',      -- Vertical line
  vertleft = '┫',  -- Vertical line with left connector
  vertright = '┣', -- Vertical line with right connector
  verthoriz = '╋', -- Vertical-horizontal intersection
})

-- Always show status line
vim.opt.laststatus = 3

-- Load terminal-specific configurations if running in Ghostty
vim.defer_fn(function()
  -- Check if Ghostty is detected
  if vim.env.TERM_PROGRAM == "ghostty" then
    -- Notify user
    vim.notify("Ghostty terminal detected. Applying optimizations.", vim.log.levels.INFO)

    -- Initialize transparency
    pcall(function() require("config.transparency").setup() end)
  end

  -- Always set up the welcome screen regardless of terminal
  pcall(function() require("config.ghostty-welcome").setup() end)
end, 100)

-- Final override to ensure no blue bar on the left of line numbers
vim.defer_fn(function()
  -- Disable sign column completely
  vim.opt.signcolumn = "no"
  
  -- Override ANY potential highlight groups that could be causing the blue bar
  vim.cmd([[
    highlight clear SignColumn
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight clear LineNr
    highlight LineNr guifg=#cc6666 guibg=NONE ctermbg=NONE
    highlight clear LineNrAbove
    highlight LineNrAbove guifg=#8aff80 guibg=NONE ctermbg=NONE
    highlight clear LineNrBelow
    highlight LineNrBelow guifg=#ff9580 guibg=NONE ctermbg=NONE
    highlight clear CursorLineNr
    highlight CursorLineNr guifg=#f0c674 gui=bold guibg=NONE ctermbg=NONE
    highlight FoldColumn guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    redraw!
  ]])
end, 500) -- Delay to ensure it runs after everything else
