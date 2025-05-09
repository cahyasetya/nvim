-- Enhanced statusline configuration
return {
  -- Lualine (Status Line)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Make sure the statusline is always shown
      vim.opt.laststatus = 3
    end,
    opts = function()
      -- Get icons from LazyVim
      local icons = require("lazyvim.config").icons
      
      -- Define colors for Tokyo Night theme
      local colors = {
        blue = "#7aa2f7",
        purple = "#bb9af7",
        cyan = "#7dcfff",
        green = "#9ece6a",
        yellow = "#e0af68",
        orange = "#ff9e64",
        red = "#f7768e",
        magenta = "#bb9af7",
        bg = "#1a1b26",
        fg = "#c0caf5",
        inactive_bg = "#24283b",
      }
      
      -- Helper functions for Ghostty status
      local function ghostty_status()
        if vim.env.TERM_PROGRAM == "ghostty" then
          return "  Ghostty"
        else
          return ""
        end
      end

      -- Mode colors
      local mode_colors = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        V = colors.purple,
        ["\22"] = colors.purple,
        c = colors.orange,
        s = colors.purple,
        S = colors.purple,
        ["\19"] = colors.purple,
        R = colors.red,
        r = colors.red,
        ["!"] = colors.red,
        t = colors.green,
      }

      -- Mode names to display
      local mode_names = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK",
        c = "COMMAND",
        s = "SELECT",
        S = "S-LINE",
        ["\19"] = "S-BLOCK",
        R = "REPLACE",
        r = "REPLACE",
        ["!"] = "SHELL",
        t = "TERMINAL",
      }

      return {
        options = {
          globalstatus = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = {
            {
              function()
                return ' ' .. mode_names[vim.fn.mode()] or vim.fn.mode()
              end,
              color = function()
                return { bg = mode_colors[vim.fn.mode()] or colors.blue, fg = "#1a1b26", gui = "bold" }
              end,
              padding = { left = 1, right = 1 },
            }
          },
          lualine_b = {
            { "branch", icon = "", color = { fg = colors.purple, gui = "bold" } },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_c = {
            {
              function() return "  " end,
              padding = { left = 0, right = 0 },
              color = { fg = colors.purple },
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 0, right = 0 },
              color = { fg = colors.fg, gui = "bold" },
            },
            {
              "filename",
              symbols = {
                modified = " ●",      -- Text to show when the file is modified.
                readonly = " ",      -- Text to show when the file is non-modifiable or readonly.
                unnamed = "◎ ",        -- Text to show for unnamed buffers.
                newfile = " ",       -- Text to show for newly created file before first write
              },
              color = { fg = colors.fg, gui = "bold" },
              padding = { left = 1, right = 0 },
            },
            { 
              "diagnostics", 
              sources = { "nvim_diagnostic" },
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_x = {
            {
              ghostty_status,
              color = { fg = colors.blue, gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              "fileformat",
              padding = { left = 1, right = 1 },
              color = { fg = colors.fg },
            },
            {
              "filetype",
              padding = { left = 1, right = 1 },
              color = { fg = colors.yellow, gui = "bold" },
            },
            {
              function() return "󰭎" end,
              color = { fg = colors.green, gui = "bold" },
            },
            {
              function() return vim.bo.fileencoding or "ascii" end,
              padding = { left = 1, right = 1 },
              color = { fg = colors.green, gui = "bold" },
            },
          },
          lualine_y = {
            {
              "progress",
              color = { fg = colors.fg, gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              "location",
              color = { fg = colors.fg, gui = "bold" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = {
            {
              function()
                local current_line = vim.fn.line(".")
                local total_lines = vim.fn.line("$")
                local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                local line_ratio = current_line / total_lines
                local index = math.ceil(line_ratio * #chars)
                return chars[index]
              end,
              color = function()
                return { bg = mode_colors[vim.fn.mode()] or colors.blue, fg = "#1a1b26" }
              end,
              padding = { left = 1, right = 1 },
            },
          },
        },
        extensions = { "neo-tree", "lazy", "mason", "trouble" },
      }
    end,
  },
}