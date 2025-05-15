-- Adds a code minimap to the right side
return {
  "petertriho/nvim-scrollbar",
  dependencies = { 
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    require("scrollbar").setup({
      show = true,
      show_in_active_only = true,
      set_highlights = true,
      handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Search = {
          text = { "-", "=" },
          priority = 0,
          color = nil,
          cterm = nil,
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 1,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 2,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 3,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 4,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 5,
          color = nil,
          cterm = nil,
          highlight = "Normal",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "neo-tree",
        "dashboard",
        "alpha",
        "lazy",
        "mason",
        "notify",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        diagnostic = true,
        search = false, -- Handled by hlslens
        gitsigns = true,
      },
    })

    -- Setup hlslens for better search visualization
    require("hlslens").setup({
      auto_enable = true,
      enable_incsearch = true,
      calm_down = true,
      nearest_only = false,
      nearest_float_when = "auto",
      float_shadow_blend = 50,
      virt_priority = 100,
      build_position_cb = function(plist, _, _, _)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
      end,
    })

    -- Integrate with gitsigns
    require("scrollbar.handlers.gitsigns").setup()

    -- Make sure the scrollbar works well with transparency
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Customize scrollbar colors to work with transparency
        vim.cmd([[highlight ScrollbarHandle guibg=#444a73 guifg=NONE blend=15]])
        vim.cmd([[highlight ScrollbarSearchHandle guibg=#47598d guifg=NONE gui=bold blend=0]])
        vim.cmd([[highlight ScrollbarSearch guibg=#344675 guifg=NONE blend=10]])
        vim.cmd([[highlight ScrollbarGitAdd guibg=#339933 guifg=NONE blend=10]])
        vim.cmd([[highlight ScrollbarGitChange guibg=#bb9900 guifg=NONE blend=10]])
        vim.cmd([[highlight ScrollbarGitDelete guibg=#cc3366 guifg=NONE blend=10]])
      end,
    })
  end,
}
