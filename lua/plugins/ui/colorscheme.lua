-- Theme and colorscheme configuration
return {
  -- Tokyo Night theme with enhanced configuration
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = {
        "qf",
        "help",
        "terminal",
        "telescope",
        "explorer",
        "packer",
        "NvimTree",
        "neo-tree",
      },
      day_brightness = 0.3,
      on_highlights = function(highlights, colors)
        -- Enhance floating windows
        highlights.NormalFloat = { bg = colors.dark3, blend = 10 }
        highlights.FloatBorder = { bg = colors.dark3, fg = colors.blue0, blend = 10 }
        
        -- Make window separators more visible
        highlights.WinSeparator = { fg = colors.blue7, bg = "NONE" }
        highlights.VertSplit = { fg = colors.blue7, bg = "NONE" }
        
        -- Enhance diagnostics visibility on transparent background
        highlights.DiagnosticError = { fg = "#ff5555", bold = true }
        highlights.DiagnosticWarn = { fg = "#ffb86c", bold = true }
        highlights.DiagnosticInfo = { fg = "#8be9fd", bold = true }
        highlights.DiagnosticHint = { fg = "#8aff80", bold = true }
        
        -- More visible line number for current line
        highlights.CursorLineNr = { fg = colors.orange, bold = true }
        
        -- More visible indent guides
        highlights.IndentBlanklineChar = { fg = colors.dark5 }
        highlights.IndentBlanklineContextChar = { fg = colors.orange, nocombine = true }
        
        -- Telescope enhancements
        highlights.TelescopeNormal = { bg = colors.bg_dark, blend = 10 }
        highlights.TelescopeBorder = { fg = colors.blue0, bg = colors.bg_dark, blend = 10 }
        highlights.TelescopePromptNormal = { bg = colors.bg_dark }
        highlights.TelescopeResultsNormal = { bg = colors.bg_dark, blend = 10 }
        highlights.TelescopeSelection = { bg = colors.bg_highlight }
        
        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green }
        highlights.GitSignsChange = { fg = colors.blue }
        highlights.GitSignsDelete = { fg = colors.red }
        
        -- Enhance completion menu
        highlights.Pmenu = { bg = colors.bg_dark, blend = 10 }
        highlights.PmenuSel = { bg = colors.bg_highlight, blend = 0 }
        highlights.PmenuSbar = { bg = colors.bg_dark }
        highlights.PmenuThumb = { bg = colors.dark5 }
        
        -- Enhance cursor line/column
        highlights.CursorLine = { bg = colors.bg_highlight, blend = 10 }
        highlights.ColorColumn = { bg = colors.bg_highlight, blend = 10 }
        
        -- Dashboard specific highlights
        highlights.DashboardHeader = { fg = colors.blue }
        highlights.DashboardCenter = { fg = colors.fg }
        highlights.DashboardShortcut = { fg = colors.orange }
        highlights.DashboardFooter = { fg = colors.comment }
      end,
    },
  },
  
  -- Catppuccin as alternative colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        navic = { enabled = true, custom_bg = "NONE" },
        treesitter = true,
        dashboard = true,
        neotree = true,
        which_key = true,
        markdown = true,
        mason = true,
      },
      highlight_overrides = {
        mocha = function(mocha)
          return {
            TelescopeBorder = { fg = mocha.blue, bg = mocha.mantle },
            TelescopeNormal = { bg = mocha.mantle },
            TelescopePromptBorder = { fg = mocha.blue, bg = mocha.mantle },
          }
        end,
      },
    },
  },
  
  -- Easy switching between themes using <leader>uc
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}