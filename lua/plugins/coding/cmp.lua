-- Consolidated nvim-cmp (completion) configuration
return {
  -- Core nvim-cmp plugin
  {
    "hrsh7th/nvim-cmp",
    lazy = false, -- Load as early as possible
    priority = 1000, -- High priority to ensure it loads before dependents
    dependencies = {
      -- Sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      -- Icons
      "onsails/lspkind.nvim",
    },
    config = function()
      -- Avoid double configuration
      if _G.cmp_configured then return end
      _G.cmp_configured = true
      
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      
      -- Setup completion
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        
        -- Snippet handling
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        -- Keymappings
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        
        -- Completion sources in priority order
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        
        -- Formatting with icons
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
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
          }),
        },
        
        -- Window appearance
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            scrollbar = false,
            side_padding = 1,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            scrollbar = false,
            max_width = 80,
            max_height = 12,
          },
        },
        
        experimental = {
          ghost_text = false,
        },
      })
      
      -- Luasnip configuration
      luasnip.config.setup({
        history = true,
        delete_check_events = "TextChanged",
      })
      
      -- Setup luasnip keymaps
      vim.keymap.set("i", "<Tab>", function()
        return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
      end, { expr = true, silent = true })
      
      vim.keymap.set("s", "<Tab>", function() luasnip.jump(1) end)
      vim.keymap.set({"i", "s"}, "<S-Tab>", function() luasnip.jump(-1) end)
    end,
  },
}