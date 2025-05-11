-- ~/.config/nvim/lua/plugins/lsp.lua
-- THIS IS THE FULL AND SIMPLIFIED CONTENT FOR DEBUGGING

return {
  -- 1. Mason: For installing LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason", -- Load when :Mason is called
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- 2. Mason-LSPConfig: Bridges Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig", -- nvim-lspconfig is a dependency
    },
    -- Configuration for mason-lspconfig will be handled within nvim-lspconfig's config
  },

  -- 3. The Core nvim-lspconfig - Main LSP setup
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Load when you open a file
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "hrsh7th/cmp-nvim-lsp", -- Temporarily commented out for simplicity, will add back for completion
      { "folke/neodev.nvim", opts = {} }, -- For Neovim Lua development
    },
    opts = {
      -- Define only a few servers for initial testing
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
        jsonls = {}, -- A simple server, good for testing
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
              -- Python formatter settings using new settings format
              formatter = {
                provider = "black",
                args = {"--line-length", "88"},
              },
              linting = {
                enabled = true,
                pylintEnabled = false,
                flake8Enabled = true,
                flake8Args = {"--indent-size=2"},
              },
            },
          },
        },
        gopls = {},
        clojure_lsp = {}
      },
    },
    config = function(_, opts)
      -- Define a custom on_attach function to run when LSP is attached to a buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Buffer local mappings
        local map = function(mode, lhs, rhs, desc)
          local options = { noremap = true, silent = true, buffer = bufnr, desc = desc }
          vim.keymap.set(mode, lhs, rhs, options)
        end
        
        -- LSP keybindings
        map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
        map('n', 'gd', vim.lsp.buf.definition, "Go to definition")
        map('n', 'K', vim.lsp.buf.hover, "Show documentation")
        map('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
        map('n', 'gr', vim.lsp.buf.references, "Find references")
        map('n', '<C-k>', vim.lsp.buf.signature_help, "Show signature help")
        map('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")
        map('n', '<leader>ca', vim.lsp.buf.code_action, "Code action")
      end

      local lspconfig = require("lspconfig")
      -- Basic capabilities; we'll add cmp_nvim_lsp capabilities back later
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- List of servers to ensure Mason installs
      local servers_to_install_via_mason = {}

      -- Loop through the servers defined in `opts.servers`
      for server_name, server_settings in pairs(opts.servers) do
        if server_settings then -- server_settings can be {} or a table with settings
          table.insert(servers_to_install_via_mason, server_name)

          local final_server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
            on_attach = on_attach,
          }, server_settings)

          lspconfig[server_name].setup(final_server_opts)
        end
      end

      -- Configure mason-lspconfig to install the servers defined in `opts.servers`
      if #servers_to_install_via_mason > 0 then
        local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if mason_lspconfig_ok then
          mason_lspconfig.setup({
            ensure_installed = servers_to_install_via_mason,
            automatic_installation = true, -- Or false, if you prefer to install manually via :Mason
          })
        else
          vim.notify("mason-lspconfig not found during nvim-lspconfig setup", vim.log.levels.WARN)
        end
      end

      -- Configure Neovim's diagnostics
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
        signs = true, -- Display diagnostic signs in the sign column
      })

      vim.notify("TEST: Simplified nvim-lspconfig loaded and configured!", vim.log.levels.INFO)
    end,
  },
} -- THIS IS THE FINAL CLOSING BRACE FOR THE 'return' STATEMENT'S TABLE.
  -- NOTHING ELSE SHOULD FOLLOW THIS LINE IN THE FILE.
