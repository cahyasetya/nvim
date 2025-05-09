-- Ghostty-specific optimizations
return {
  {
    "LazyVim/LazyVim",
    event = "VeryLazy",
    config = function()
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Terminal-specific settings for better performance
        
        -- Optimize terminal responsiveness
        vim.g.terminal_responsive = true
        
        -- Fast updatetime for better user experience
        vim.opt.updatetime = 100
        
        -- Better cursor behavior
        vim.opt.ttimeoutlen = 10
        
        -- No need to wait for the screen to redraw
        vim.opt.ttyfast = true
        
        -- Ensure Ghostty terminal has true colors
        vim.opt.termguicolors = true
        
        -- Cursor blinking settings
        vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
        
        -- Add special key mappings for Ghostty
        vim.api.nvim_create_autocmd("TermOpen", {
          callback = function()
            -- Enable cursor line only for terminal if not enabled globally
            if not vim.o.cursorline then
              vim.opt_local.cursorline = true
            end
            
            -- Hide line numbers for terminal
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            
            -- Set proper terminal size
            vim.cmd("resize " .. math.floor(vim.api.nvim_get_option("lines") * 0.3))
          end,
        })
        
        -- Performance optimizations for Ghostty terminal
        vim.api.nvim_create_autocmd("UIEnter", {
          once = true,
          callback = function()
            -- Adjust redraw settings for better performance
            vim.cmd("redraw")
            
            -- Set proper terminal size if terminal is fullscreen
            if vim.fn.system("ghostty +is-fullscreen 2>/dev/null") == "true" then
              vim.g.ghostty_is_fullscreen = true
            end
          end,
        })
      end
    end,
  },
  
  -- Enhanced scrolling and UI responsiveness for Ghostty
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    enabled = function()
      return vim.env.TERM_PROGRAM == "ghostty"
    end,
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,              -- Hide cursor while scrolling
        stop_eof = true,                 -- Stop at EOF
        use_local_scrolloff = false,     -- Use local scrolloff
        respect_scrolloff = false,       -- Respect scrolloff
        cursor_scrolls_alone = true,     -- Cursor will keep its column
        easing_function = "sine",        -- Easing function
        pre_hook = nil,                  -- Function to run before the scrolling animation starts
        post_hook = nil,                 -- Function to run after the scrolling animation ends
        performance_mode = true,         -- Disable "Performance Mode" on all buffers
      })
    end,
  },
  
  -- Enhance the colors for Ghostty Terminal
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    enabled = function()
      return vim.env.TERM_PROGRAM == "ghostty"
    end,
    config = function()
      require("colorizer").setup({
        "*", -- all filetypes
        css = { css = true, css_fn = true },
        html = { names = true },
      }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
      })
    end,
  },
}