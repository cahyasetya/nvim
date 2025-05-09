-- Advanced terminal integration for Ghostty
return {
  -- ToggleTerm for easy terminal access
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>t", desc = "Toggle terminal (float)" },
      { "<leader>tv", desc = "Toggle terminal (vertical)" },
      { "<leader>th", desc = "Toggle terminal (horizontal)" },
      { "<C-\\>", desc = "Toggle terminal (float)" },
    },
    opts = function()
      local highlights = require("tokyonight.colors").setup()
      
      -- Enhanced terminal configuration with Ghostty detection
      local termOpts = {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
        open_mapping = "<C-\\>",
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.85)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          winblend = 10,
        },
        highlights = {
          FloatBorder = {
            guifg = highlights.blue,
          },
          NormalFloat = {
            link = "Normal",
          },
        },
      }
      
      -- Apply Ghostty-specific optimizations
      if vim.env.TERM_PROGRAM == "ghostty" then
        termOpts.float_opts.winblend = 15
        termOpts.env = {
          -- For better terminal-in-terminal experience
          TERM = "xterm-256color",
        }
      end
      
      return termOpts
    end,
    config = function(_, opts)
      require("toggleterm").setup(opts)
      
      -- Define key mappings for terminal
      local function set_terminal_keymaps()
        local options = { buffer = 0 }
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], options)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], options)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], options)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], options)
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], options)
      end
      
      -- Auto commands
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.cmd("startinsert!")
        end,
      })
      
      -- Command to open a floating terminal
      vim.api.nvim_create_user_command("TermFloat", function()
        require("toggleterm").toggle(1, nil, nil, "float")
      end, {})
      
      -- Command to open a vertical terminal
      vim.api.nvim_create_user_command("TermVertical", function()
        require("toggleterm").toggle(2, nil, nil, "vertical")
      end, {})
      
      -- Command to open a horizontal terminal
      vim.api.nvim_create_user_command("TermHorizontal", function()
        require("toggleterm").toggle(3, nil, nil, "horizontal")
      end, {})
      
      -- Custom lazygit terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })
      
      -- Function to toggle lazygit terminal
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      
      -- Map leader g to open lazygit
      vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
      
      -- Add Ghostty Terminal command if detected
      if vim.env.TERM_PROGRAM == "ghostty" then
        vim.notify("Ghostty terminal detected and integrated with Neovim", vim.log.levels.INFO)
      end
    end,
  },
  
  -- Add a better command-line experience
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "FloatBorder",
            },
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
