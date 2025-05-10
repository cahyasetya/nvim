-- General UI improvements and components
return {
  -- Better UI for notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      background_colour = "#000000",
      render = "wrapped-compact",
      stages = "fade",
    },
  },

  -- Better UI for input and selecting
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = {
          winblend = 5,
          winhighlight = "Normal:Normal,NormalNC:Normal",
        },
      },
      select = {
        backend = { "telescope", "fzf", "builtin" },
        builtin = {
          win_options = {
            winblend = 5,
            winhighlight = "Normal:Normal,NormalNC:Normal",
          },
        },
        telescope = {
          layout_strategy = "center",
        },
      },
    },
  },

  -- Enhanced buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            highlight = "Directory",
            text_align = "left",
          },
        },
        separator_style = "thin",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },

  -- Highly customizable floating animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- Don't use animations when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        cursor = {
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
          path = animate.gen_path.line({
            predicate = function()
              -- Only enable cursor animation in normal mode
              return vim.fn.mode() == "n"
            end,
          }),
        },
      }
    end,
  },
  
  -- Better indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
        highlight = { "Function", "Label" },
        priority = 500,
      },
    },
  },

  -- Add pretty icons to the completion menu
  {
    "onsails/lspkind.nvim",
    event = "VeryLazy",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end,
  },
}