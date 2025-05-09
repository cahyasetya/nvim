-- Performance optimizations for Neovim with Ghostty
return {
  -- Better buffer handling
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Wait a bit to let the terminal settle
        vim.defer_fn(function()
          require("incline").setup({
            window = {
              margin = { horizontal = 1, vertical = 0 },
              padding = 0,
              padding_char = " ",
              placement = { horizontal = "right", vertical = "top" },
              width = "fit",
              winhighlight = {
                active = {
                  EndOfBuffer = "None",
                  Normal = "InclineNormal",
                  Search = "None",
                },
                inactive = {
                  EndOfBuffer = "None",
                  Normal = "InclineNormalNC",
                  Search = "None",
                },
              },
              zindex = 30,
            },
            hide = {
              cursorline = false,
              focused_win = false,
              only_win = false,
            },
            render = function(props)
              local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
              local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
              
              local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and " ●" or ""
              
              local buffer_is_readonly = vim.api.nvim_buf_get_option(props.buf, "readonly")
              local lock_icon = buffer_is_readonly and " " or ""
              
              if ft_icon then
                filename = " " .. ft_icon .. " " .. filename
              end
              
              local result = { filename, modified, lock_icon }
              
              if props.focused then
                return result
              else
                return result
              end
            end,
          })
        end, 200)
      end
    end,
  },
  
  -- Defer loading of UI components for faster startup
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Defer loading UI components
        opts.performance = opts.performance or {}
        opts.performance.rtp = {
          -- Disable some unused builtin plugins
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        }
        
        -- Optimize performance for Ghostty
        vim.g.ghostty_detected = true
        
        -- Only redraw when needed
        vim.opt.lazyredraw = true
        
        -- Fast updatetime
        vim.opt.updatetime = 100
        
        -- Faster key response
        vim.opt.timeout = true
        vim.opt.timeoutlen = 500
        vim.opt.ttimeoutlen = 10
        
        -- Reduce displayed messages
        vim.opt.shortmess:append("c")
        
        -- Optimize for faster terminal
        vim.g.terminal_responsive = true
      end
    end,
  },
  
  -- Better syntax highlighting performance with TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Optimize treesitter for performance
        opts.highlight = opts.highlight or {}
        opts.highlight.additional_vim_regex_highlighting = false
        
        -- Disable slow parsers
        local disabled_languages = { "phpdoc", "tree-sitter-phpdoc", "comment", "markdown_inline" }
        
        opts.highlight.disable = function(lang, bufnr)
          -- Check if language should be disabled
          if vim.tbl_contains(disabled_languages, lang) then
            return true
          end
          
          -- Disable for large files
          local max_filesize = 100 * 1024 -- 100KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          
          return false
        end
      end
    end,
  },
}
