-- Enhanced Neo-tree file explorer that looks great in Ghostty
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = " Files" },
        { source = "buffers", display_name = " Bufs" },
        { source = "git_status", display_name = " Git" },
        { source = "document_symbols", display_name = " Symbols" },
      },
    },
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    popup_border_style = "rounded",
    sort_case_insensitive = true,
    disable_netrw = true,
    hijack_netrw = false,
    
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      use_libuv_file_watcher = true,
      group_empty_dirs = false,
      window = {
        mappings = {
          ["<space>"] = "none",
          ["Y"] = { 
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
              vim.notify("Copied path: " .. path)
            end,
            desc = "Copy path to clipboard",
          },
        },
      },
    },
    
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "none",
        ["o"] = "open",
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["R"] = "refresh",
        ["a"] = { 
          "add",
          config = {
            show_path = "relative", -- "none", "relative", "absolute"
          }
        },
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["q"] = "close_window",
      },
      auto_expand_width = false,
      popup_border_style = "rounded",
      border = "single", -- "none", "single", "double", "rounded" or "shadow"
      wipe_out_empty_visual_lines = true,
    },

    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      modified = {
        symbol = "●",
        highlight = "NeoTreeModified",
      },
    },
    
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          -- Automatically hide the cursor in Neo-tree windows
          vim.cmd("setlocal cursorlineopt=line")
          vim.cmd("setlocal conceallevel=3")
          
          -- Ensure the border extends full height
          vim.cmd("setlocal fillchars=eob:\\ ")
          vim.cmd("hi NeoTreeEndOfBuffer guibg=NONE")
          vim.cmd("hi NeoTreeNormal guibg=NONE")
          vim.cmd("hi NeoTreeWinSeparator guifg=#3b4261 guibg=NONE")
        end,
      },
      {
        event = "neo_tree_window_after_open",
        handler = function(_)
          -- Force update of the separator when the window opens
          vim.cmd("hi VertSplit guifg=#3b4261 guibg=NONE")
          vim.cmd("hi WinSeparator guifg=#3b4261 guibg=NONE")
        end,
      },
    },
  },
}