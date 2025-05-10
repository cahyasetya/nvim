-- Neo-tree file explorer with beautiful UI
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Explorer",
    },
    {
      "<F2>",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Explorer F2",
    },
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Explorer Ctrl+N",
    },
  },
  init = function()
    -- Create an Explorer command
    vim.api.nvim_create_user_command("Explorer", function()
      require("neo-tree.command").execute({ toggle = true })
    end, {})

    -- Modify bufferline to remove "File Explorer" text
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local ok, bufferline = pcall(require, "bufferline")
        if ok then
          bufferline.setup({
            options = {
              offsets = {
                {
                  filetype = "neo-tree",
                  text = "", -- Empty text removes "File Explorer"
                  highlight = "Directory",
                  text_align = "left"
                }
              }
            }
          })
        end
      end,
      once = true
    })
  end,
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = " Files" },
        { source = "buffers", display_name = " Buffers" },
        { source = "git_status", display_name = " Git" },
        { source = "document_symbols", display_name = " Symbols" },
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
        width = "100%",
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
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
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "●",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖", -- this can only be used in the git_status source
          renamed   = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    },
    window = {
      position = "left",
      width = 30,
      popup_border_style = "rounded",
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = { 
          "toggle_node", 
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        ["C"] = "close_node",
        -- ['C'] = 'close_all_subnodes',
        ["z"] = "close_all_nodes",
        --["Z"] = "expand_all_nodes",
        ["a"] = { 
          "add",
          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none" -- "none", "relative", "absolute"
          }
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                              -- in whatever position is specified in window.position
                            -- "open_current",  -- netrw disabled, opening a directory opens within the
                                              -- window like netrw would, regardless of window.position
                            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                                      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- ["D"] = "fuzzy_sorter_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },
    
      commands = {} -- Add a custom command or override a global one using the same function name
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        }
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        }
      }
    },
    document_symbols = {
      follow_cursor = false,
      client_filters = "first",
      renderers = {
        root = {
          {"indent"},
          {"icon", default="C" },
          {"name", zindex = 10},
        },
        symbol = {
          {"indent", with_expanders = true},
          {"kind_icon", default="?" },
          {"container",
            content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
            }
          }
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "jump_to_symbol",
          ["o"] = "jump_to_symbol",
          ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
          ["d"] = "noop",
          ["y"] = "noop",
          ["x"] = "noop",
          ["p"] = "noop",
          ["c"] = "noop",
          ["m"] = "noop",
          ["a"] = "noop",
        },
      },
      custom_kinds = {
        -- define custom kinds here (also need to define them in the highlight groups)
        -- ccls
        -- [252] = { icon = "ﴯ", name = "TypeAlias" },
        -- [253] = { icon = "", name = "Parameter" },
        -- [254] = { icon = "", name = "StaticMethod" },
        -- [255] = { icon = "ﰠ", name = "Macro" },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          -- Add fancy UI styling
          vim.cmd("setlocal cursorlineopt=line")
          vim.cmd("setlocal fillchars=eob:\\ ")
          vim.cmd("hi NeoTreeNormal guibg=NONE")
          vim.cmd("hi NeoTreeEndOfBuffer guibg=NONE")
          vim.cmd("hi NeoTreeWinSeparator guifg=#3b4261 guibg=NONE")
          vim.cmd("hi NeoTreeRootName guifg=#bb9af7 gui=bold")
          vim.cmd("hi NeoTreeFileName guifg=#c0caf5")
          vim.cmd("hi NeoTreeDirectoryName guifg=#7aa2f7 gui=bold")
          vim.cmd("hi NeoTreeDirectoryIcon guifg=#7aa2f7")

          -- Fix alignment with bufferline
          vim.cmd("setlocal conceallevel=3")
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.numberwidth = 1
        end
      },
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            -- Hide "File Explorer" text in bufferline
            local ok, bufferline = pcall(require, "bufferline")
            if ok then
              bufferline.setup({
                options = {
                  offsets = {
                    {
                      filetype = "neo-tree",
                      text = "",
                      highlight = "Directory",
                      text_align = "left"
                    }
                  }
                }
              })
            end
          end
        end
      },
    },
  },
}