-- Unified LSP configuration (all-in-one file)
return {
  -- Add a key mapping to open Mason
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  -- Explicitly disable LazyVim's LSP plugins to avoid conflicts
  { import = "lazyvim.plugins.lsp", enabled = false },

  -- Diagnostic setup (separate from LSP to avoid buffer errors)
  {
    "neovim/nvim-lspconfig",
    name = "diagnostics-setup",
    priority = 1000,  -- Load early
    cond = false,     -- Don't actually load the plugin, just run the init function
    init = function()
      -- Configure diagnostics globally
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
        signs = false,
      })
    end,
  },

  -- Disable LazyVim's built-in LSP support
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Disable LazyVim's LSP configuration
      opts.lsp = {
        -- Disable automatic setup
        servers = {},
        setup = {},
        autoformat = false,
      }
      return opts
    end,
  },
  
  -- Mason for managing LSP servers, formatters, and linters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      -- Let LazyVim manage the installation, don't try to install on our own
      -- to avoid "Package is already installing" errors
    },
  },
  
  -- Mason-lspconfig handles server installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    opts = {
      -- Server-specific settings. See `:help lspconfig-setup`
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        jsonls = {},
        html = {},
        cssls = {},
        tsserver = {}, -- TypeScript server
        pyright = {},
        bashls = {},
        -- Add any other servers you want to configure
      },
      setup = {},
    },
    config = function(_, opts)
      -- Setup each LSP server
      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )
      
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end
        
        require("lspconfig")[server].setup(server_opts)
      end
      
      -- No need for complex server mapping since we're using standard names in mason-lspconfig
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          setup(server_name)
        end,
      })
    end,
  },
  
  -- Formatters & linters are now in coding-unified.lua
  -- No need to import them separately here
  
  -- LSP UI enhancements
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbol_in_winbar = { enable = false },
      ui = {
        title = true,
        border = "rounded",
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "💡",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  
  -- Function signature as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = { border = "rounded" },
      hint_enable = false,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      always_trigger = false,
      hint_prefix = "🔍 ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 12,
      max_width = 120,
      wrap = true,
      padding = "",
    },
    config = function(_, opts)
      -- Handle potential conflicts with Noice
      local noice_loaded, noice = pcall(require, "noice")
      
      -- Set up signature
      require("lsp_signature").setup(opts)
      
      -- If Noice is loaded, ensure its signature help is disabled
      if noice_loaded then
        noice.setup({
          lsp = { signature = { enabled = false } }
        })
      end
    end,
  },
}
