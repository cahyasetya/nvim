-- Transparency settings for Ghostty integration
local M = {}

-- Function to apply transparency settings
function M.enable_transparency()
  vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi NonText guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi LineNr guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi Folded guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi SpecialKey guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi VertSplit guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi SignColumn guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi EndOfBuffer guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi NormalFloat guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi FloatBorder guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi CursorLine guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi StatusLine guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi StatusLineNC guibg=NONE ctermbg=NONE]])
end

-- Function to disable transparency settings (using Tokyo Night background)
function M.disable_transparency()
  vim.cmd([[hi Normal guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi NonText guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi LineNr guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi Folded guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi SpecialKey guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi VertSplit guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi SignColumn guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi EndOfBuffer guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi NormalFloat guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi FloatBorder guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi CursorLine guibg=#1f2335 ctermbg=235]])
  vim.cmd([[hi StatusLine guibg=#1f2335 ctermbg=235]])
  vim.cmd([[hi StatusLineNC guibg=#1f2335 ctermbg=235]])
end

-- Setup transparency
function M.setup()
  if vim.env.TERM_PROGRAM == "ghostty" then
    -- Set transparency state
    vim.g.transparent_enabled = true
    
    -- Apply transparency settings
    M.enable_transparency()
    
    -- Create autocommand to reapply transparency after colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        if vim.g.transparent_enabled then
          vim.defer_fn(function()
            M.enable_transparency()
          end, 10)
        end
      end,
    })
    
    -- Create command to toggle transparency
    vim.api.nvim_create_user_command("ToggleTransparency", function()
      if vim.g.transparent_enabled then
        M.disable_transparency()
        vim.g.transparent_enabled = false
        vim.notify("Transparency disabled")
      else
        M.enable_transparency()
        vim.g.transparent_enabled = true
        vim.notify("Transparency enabled")
      end
    end, {})
  end
end

return M