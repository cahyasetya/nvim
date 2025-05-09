-- Welcome message for Ghostty + Neovim integration
local M = {}

-- ASCII art logo
M.logo = [[
  ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓▄▄▄█████▓▓██   ██▓
 ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒▓  ██▒ ▓▒ ▒██  ██▒
▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░▒ ▓██░ ▒░  ▒██ ██░
░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░ ░ ▓██▓ ░   ░ ▐██▓░
░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░   ▒██▒ ░   ░ ██▒▓░
 ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░     ▒ ░░      ██▒▒▒ 
  ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░        ░      ▓██ ░▒░ 
░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░          ░      ▒ ▒ ░░  
      ░  ░  ░  ░    ░ ░        ░                      ░ ░     
                                                       ░ ░     
         ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
         ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
        ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
        ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
        ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
        ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
        ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
           ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
                 ░    ░  ░    ░ ░        ░   ░         ░   
                                        ░                   
]]

-- Information about the setup
M.info = [[
  Your Neovim is now configured for an optimal experience with Ghostty terminal!
  
  Key Features:
  • Transparent background that works with Ghostty's blurry background
  • Tokyo Night theme that matches your Ghostty terminal
  • Enhanced UI elements with beautiful animations
  • Optimized colors and syntax highlighting
  • Ghostty-specific terminal integrations
  
  Key Commands:
  • <leader>t   : Open floating terminal
  • <leader>ut  : Toggle transparency
  • <leader>uc  : Toggle colorscheme
  • <C-\>       : Toggle terminal
  • <Esc>       : Exit terminal mode
  
  The configuration has been designed to provide a beautiful, consistent
  experience between Ghostty and Neovim with minimal latency and maximum
  aesthetic appeal.
]]

-- Function to show the welcome message
function M.show_welcome_screen()
  if vim.env.TERM_PROGRAM == "ghostty" then
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")
    
    local win_width = math.ceil(width * 0.8)
    local win_height = math.ceil(height * 0.8)
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)
    
    local opts = {
      style = "minimal",
      relative = "editor",
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      border = "rounded",
    }
    
    local logo_lines = vim.split(M.logo, "\n")
    local info_lines = vim.split(M.info, "\n")
    
    local lines = {}
    for _, line in ipairs(logo_lines) do
      table.insert(lines, line)
    end
    
    table.insert(lines, "")
    table.insert(lines, "")
    
    for _, line in ipairs(info_lines) do
      table.insert(lines, line)
    end
    
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    local win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_win_set_option(win, "winblend", 10)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "filetype", "GhosttyWelcome")
    
    -- Set syntax highlighting
    vim.api.nvim_set_hl(0, "GhosttyWelcomeLogo", { fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "GhosttyWelcomeInfo", { fg = "#c0caf5" })
    vim.api.nvim_set_hl(0, "GhosttyWelcomeKey", { fg = "#ff9e64", bold = true })
    
    -- Apply highlights
    for i = 1, #logo_lines do
      vim.api.nvim_buf_add_highlight(buf, -1, "GhosttyWelcomeLogo", i - 1, 0, -1)
    end
    
    for i = #logo_lines + 2, #lines do
      vim.api.nvim_buf_add_highlight(buf, -1, "GhosttyWelcomeInfo", i - 1, 0, -1)
    end
    
    -- Highlight key sections
    local key_lines = { #logo_lines + 7, #logo_lines + 8, #logo_lines + 9, #logo_lines + 10, #logo_lines + 11 }
    for _, line in ipairs(key_lines) do
      vim.api.nvim_buf_add_highlight(buf, -1, "GhosttyWelcomeKey", line - 1, 2, 13)
    end
    
    -- Close with any key press
    vim.keymap.set("n", "<Esc>", "<Cmd>q<CR>", { buffer = buf, noremap = true, silent = true })
    vim.keymap.set("n", "q", "<Cmd>q<CR>", { buffer = buf, noremap = true, silent = true })
    vim.keymap.set("n", "<CR>", "<Cmd>q<CR>", { buffer = buf, noremap = true, silent = true })
    vim.keymap.set("n", "<Space>", "<Cmd>q<CR>", { buffer = buf, noremap = true, silent = true })
    
    -- Auto close after 10 seconds
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, 10000)
    
    return win, buf
  end
  return nil, nil
 end

-- Setup welcome message on fresh Neovim start
function M.setup()
  if vim.env.TERM_PROGRAM == "ghostty" then
    -- Add a welcome message to be shown on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only show on fresh Neovim start (no args) and not in a git commit
        local should_show = (#vim.fn.argv() == 0)
                           and vim.bo.filetype ~= "gitcommit"
                           and vim.bo.filetype ~= "gitrebase"
        
        if should_show then
          -- Small delay to ensure everything is loaded
          vim.defer_fn(function()
            M.show_welcome_screen()
          end, 10)
        end
      end,
    })
    
    -- Create a command to show the welcome screen
    vim.api.nvim_create_user_command("GhosttyWelcome", function()
      M.show_welcome_screen()
    end, { desc = "Show Ghostty welcome screen" })
  end
end

return M