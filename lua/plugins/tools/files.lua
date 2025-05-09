-- File management plugins
return {
  -- File explorer alternatives
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = true,
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  
  -- File browser popup
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<C-w>"] = function() vim.cmd('normal vbd') end,
              },
              ["n"] = {
                ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["N"] = require("telescope").extensions.file_browser.actions.create,
                ["r"] = require("telescope").extensions.file_browser.actions.rename,
                ["d"] = require("telescope").extensions.file_browser.actions.remove,
                ["c"] = require("telescope").extensions.file_browser.actions.copy,
                ["m"] = require("telescope").extensions.file_browser.actions.move,
              },
            },
          },
        },
      }
      require("telescope").load_extension "file_browser"
      
      -- Add key mapping
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true, desc = "File Browser" }
      )
    end,
  },
  
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "Makefile", "package.json", "pyproject.toml", "go.mod" },
        detection_methods = { "pattern", "lsp" },
        silent_chdir = true,
        show_hidden = true,
        scope_chdir = "global",
      }
      
      -- Load telescope integration
      require('telescope').load_extension('projects')
      
      -- Add key mapping
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fp",
        ":Telescope projects<CR>",
        { noremap = true, desc = "Projects" }
      )
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  
  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      pre_save = nil,
      save_empty = false,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}