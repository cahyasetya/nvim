-- Compatibility and optimizations for Ghostty terminal
return {
  -- Theme configuration to match Ghostty
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- Making line numbers more visible against transparent bg
        hl.LineNr = { fg = c.blue }
        hl.CursorLineNr = { fg = c.orange, bold = true }
        
        -- Add subtle background to some UI elements for better contrast
        hl.NormalFloat = { bg = c.bg_dark, blend = 10 }
        hl.FloatBorder = { fg = c.blue, bg = c.bg_dark, blend = 10 }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Enhanced status line configuration
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 
          {
            "mode",
            fmt = function(str)
              return str:sub(1,1)
            end,
          }
        },
        lualine_b = { "branch" },
        lualine_c = { 
          { "filename", path = 1 }, 
          {
            "diagnostics",
            symbols = {
              error = " ", 
              warn = " ", 
              info = " ", 
              hint = " ",
            },
          },
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
      shade_terminals = false,
      highlights = {
        FloatBorder = { link = "FloatBorder" },
        NormalFloat = { link = "NormalFloat" },
      },
    },
  },

  -- Enhance the UI for a better visual experience
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      select = {
        backend = { "telescope", "fzf", "builtin" },
        builtin = {
          border = "rounded",
          win_options = {
            winblend = 10,
          },
        },
      },
    },
  },

  -- Enhance window transitions
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinNew",
    config = true,
    opts = {
      highlight = {
        bg = "#1a1b26",
        fg = "#7aa2f7",
      },
      interval = 30,
      no_exec_files = { "neo-tree", "aerial" },
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    },
  },

  -- Add smooth scrolling to match Ghostty's smooth experience
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "sine",
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- Add beautiful indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "dashboard",
          "mason",
          "lazy",
          "notify",
        },
      },
    },
  },

  -- Special Ghostty-specific terminal detection
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Apply Ghostty-specific settings
        vim.g.ghostty_detected = true
        
        -- Set true colors
        vim.opt.termguicolors = true
        
        -- Set cursor style based on mode for Ghostty
        vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"
      end
    end,
  },
}
