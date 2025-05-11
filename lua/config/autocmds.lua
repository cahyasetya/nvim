-- Auto save when buffer loses focus
vim.api.nvim_create_autocmd({"FocusLost", "BufLeave"}, {
  pattern = {"*"},
  command = "silent! wall",
  nested = true,
  group = vim.api.nvim_create_augroup("AutoSaveOnFocusLost", { clear = true }),
})

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Detect Ghostty terminal and apply specific settings
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    if vim.env.TERM_PROGRAM == "ghostty" then
      vim.notify("Ghostty terminal detected. Applying optimizations.", vim.log.levels.INFO)
      
      -- Enable undercurl and strikethrough in Ghostty
      vim.cmd([[let &t_Cs = "\e[4:3m"]])
      vim.cmd([[let &t_Ce = "\e[4:0m"]])
      vim.cmd([[let &t_Ts = "\e[9m"]])
      vim.cmd([[let &t_Te = "\e[29m"]])
      
      -- Check for background transparency
      if vim.g.transparent_enabled then
        vim.notify("Transparency enabled for Ghostty integration", vim.log.levels.INFO)
      end
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-create directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Set line number colors on color scheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Line numbers
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#cc6666", italic = true })
    -- Line numbers above cursor (green)
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#8aff80", italic = true })
    -- Line numbers below cursor (red)
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ff9580", italic = true })
    -- Current line number (gold)
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f0c674", bold = true })
  end,
  group = vim.api.nvim_create_augroup("CustomLineNumbers", { clear = true }),
})

-- Ensure sign column is disabled with the most aggressive approach
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "WinEnter", "BufRead", "BufNewFile", "FileType", "CursorMoved", "CursorMovedI"}, {
  pattern = {"*"},
  callback = function()
    -- Forcibly disable sign column
    vim.opt.signcolumn = "no"

    -- Clear ALL potential highlight groups that could cause the blue bar
    vim.cmd([[
      highlight clear SignColumn
      highlight SignColumn guibg=NONE ctermbg=NONE
      highlight LineNr guifg=#cc6666 guibg=NONE ctermbg=NONE
      highlight LineNrAbove guifg=#8aff80 guibg=NONE ctermbg=NONE
      highlight LineNrBelow guifg=#ff9580 guibg=NONE ctermbg=NONE
      highlight CursorLineNr guifg=#f0c674 gui=bold guibg=NONE ctermbg=NONE

      " Clear any diagnostic/git signs that might be auto-enabling the column
      highlight clear DiagnosticSignError
      highlight clear DiagnosticSignWarn
      highlight clear DiagnosticSignInfo
      highlight clear DiagnosticSignHint
      highlight clear GitSignsAdd
      highlight clear GitSignsChange
      highlight clear GitSignsDelete
    ]])
  end,
  group = vim.api.nvim_create_augroup("AggressiveSignColumnRemoval", { clear = true }),
})
