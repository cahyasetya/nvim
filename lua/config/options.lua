-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- UI Improvements for Ghostty
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.cursorline = true      -- Highlight the current line
vim.opt.pumblend = 10          -- Make popup menu semi-transparent
vim.opt.winblend = 10          -- Make floating windows semi-transparent

-- Line numbers and text display
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.wrap = false           -- Don't wrap lines
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible left/right of cursor
vim.opt.showmode = false       -- Don't show mode (shown in statusline)

-- Custom line number colors
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cc6666", italic = true })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#8aff80", italic = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ff9580", italic = true })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f0c674", bold = true })

-- Ghostty-specific terminal settings
if vim.env.TERM_PROGRAM == "ghostty" then
  -- Fix potential cursor display issues in Ghostty
  vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"
  
  -- Enable undercurl support in Ghostty
  vim.cmd([[let &t_Cs = "\e[4:3m"]])
  vim.cmd([[let &t_Ce = "\e[4:0m"]])
  
  -- Fix potential timer issues
  vim.opt.ttimeoutlen = 10
end

-- Set sign column to no to eliminate the blue bar
vim.opt.signcolumn = "no"

-- Try to forcefully clear the problematic blue bar
vim.cmd([[
  augroup RemoveBlueBar
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter * hi clear SignColumn
    autocmd VimEnter,BufEnter,WinEnter * hi Normal guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * hi SignColumn guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * hi FoldColumn guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * hi LineNr guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * hi NormalNC guibg=NONE ctermbg=NONE
    autocmd VimEnter,BufEnter,WinEnter * set signcolumn=no
  augroup END
]])

-- Enable mouse support
vim.opt.mouse = "a"            -- Enable mouse in all modes

-- Indentation settings (already in init.lua, but keeping consistent)
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.tabstop = 2            -- 2 spaces for tabs
vim.opt.shiftwidth = 2         -- 2 spaces for indentation
vim.opt.softtabstop = 2        -- 2 spaces when tab is pressed
vim.opt.smartindent = true     -- Smart auto-indenting

-- Search improvements
vim.opt.ignorecase = true      -- Ignore case when searching
vim.opt.smartcase = true       -- Unless search contains uppercase
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Show search matches as you type

-- File management
vim.opt.backup = false         -- Don't create backup files
vim.opt.swapfile = false       -- Don't create swap files
vim.opt.undofile = true        -- Enable persistent undo

-- Initial highlight setup
vim.cmd([[
  highlight LineNr guifg=#cc6666
  highlight LineNrAbove guifg=#8aff80
  highlight LineNrBelow guifg=#ff9580
  highlight CursorLineNr guifg=#f0c674 gui=bold
]])
