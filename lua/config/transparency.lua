-- Transparency settings for Ghostty integration
local M = {}

-- Function to apply transparency settings
function M.enable_transparency()
  -- Basic UI elements
  vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi NonText guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi LineNr guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi Folded guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi SpecialKey guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi VertSplit guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi SignColumn guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi EndOfBuffer guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi CursorLine guibg=NONE ctermbg=NONE]])
  
  -- Floating windows and popups
  vim.cmd([[hi NormalFloat guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi FloatBorder guibg=NONE ctermbg=NONE]])
  
  -- Status line
  vim.cmd([[hi StatusLine guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi StatusLineNC guibg=NONE ctermbg=NONE]])
  
  -- Indent guides
  vim.cmd([[hi IndentBlanklineChar guifg=#3b3f51 gui=nocombine]])
  vim.cmd([[hi IndentBlanklineContextChar guifg=#5d86b4 gui=nocombine]])
  vim.cmd([[hi IblIndent guifg=#3b3f51 gui=nocombine]])
  vim.cmd([[hi IblScope guifg=#5d86b4 gui=nocombine]])
  
  -- Git-related
  vim.cmd([[hi GitSignsAdd guibg=NONE]])
  vim.cmd([[hi GitSignsChange guibg=NONE]])
  vim.cmd([[hi GitSignsDelete guibg=NONE]])
  vim.cmd([[hi GitSignsCurrentLineBlame guifg=#6b727f guibg=NONE]])
  
  -- Scrollbar
  vim.cmd([[hi ScrollbarHandle guibg=#444a73 guifg=NONE blend=15]])
  vim.cmd([[hi ScrollbarSearchHandle guibg=#47598d guifg=NONE gui=bold blend=0]])
  vim.cmd([[hi ScrollbarSearch guibg=#344675 guifg=NONE blend=10]])
  vim.cmd([[hi ScrollbarGitAdd guibg=#339933 guifg=NONE blend=10]])
  vim.cmd([[hi ScrollbarGitChange guibg=#bb9900 guifg=NONE blend=10]])
  vim.cmd([[hi ScrollbarGitDelete guibg=#cc3366 guifg=NONE blend=10]])
  
  -- Function signature hint
  vim.cmd([[hi LspSignatureActiveParameter guifg=#83d3ff guibg=NONE gui=bold,underline]])
  vim.cmd([[hi SignatureHintVirtual guifg=#8a98c9 blend=20]])
  
  -- Apply transparency to any potential new plugin elements
  vim.cmd([[hi clear CursorLineNr]])
  vim.cmd([[hi CursorLineNr guifg=#f0c674 gui=bold guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi FoldColumn guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi NormalNC guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi MsgArea guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi TelescopeBorder guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi TelescopeNormal guibg=NONE ctermbg=NONE]])
  vim.cmd([[hi GitBlameVirtText guifg=#6b727f guibg=NONE]])
  
  -- Diagnostic virtual text
  vim.cmd([[hi DiagnosticVirtualTextError guibg=NONE]])
  vim.cmd([[hi DiagnosticVirtualTextWarn guibg=NONE]])
  vim.cmd([[hi DiagnosticVirtualTextInfo guibg=NONE]])
  vim.cmd([[hi DiagnosticVirtualTextHint guibg=NONE]])
  
  -- Make diagnostic floating windows look good with transparency
  vim.cmd([[hi DiagnosticError guibg=NONE]])
  vim.cmd([[hi DiagnosticWarn guibg=NONE]])
  vim.cmd([[hi DiagnosticInfo guibg=NONE]])
  vim.cmd([[hi DiagnosticHint guibg=NONE]])
  
  -- Apply transparency to other newly added elements from our plugins
  vim.cmd([[hi WinSeparator guifg=#3b4261 guibg=NONE]])
  vim.cmd([[hi VertSplit guifg=#3b4261 guibg=NONE]])
  
  -- Ensure neogit UI looks good with transparency
  vim.cmd([[hi NeogitHunkHeader guibg=#343e5d blend=10]])
  vim.cmd([[hi NeogitHunkHeaderHighlight guibg=#4a548c blend=10 gui=bold]])
  vim.cmd([[hi NeogitDiffAdd guibg=#283b4d blend=10]])
  vim.cmd([[hi NeogitDiffDelete guibg=#3c2c3c blend=10]])
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
  
  -- Reset plugin-specific elements too
  vim.cmd([[hi ScrollbarHandle guibg=#454a73 blend=0]])
  vim.cmd([[hi GitSignsCurrentLineBlame guifg=#565f89 guibg=#1a1b26]])
  vim.cmd([[hi TelescopeBorder guibg=#1a1b26 ctermbg=234]])
  vim.cmd([[hi TelescopeNormal guibg=#1a1b26 ctermbg=234]])
  
  -- Indent guides with background
  vim.cmd([[hi IblIndent guifg=#3b3f51 guibg=#1a1b26 gui=nocombine]])
  vim.cmd([[hi IblScope guifg=#5d86b4 guibg=#1a1b26 gui=nocombine]])
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
    
    -- Add keybinding to toggle transparency
    vim.keymap.set("n", "<leader>tt", ":ToggleTransparency<CR>", { desc = "Toggle transparency" })
  end
end

return M