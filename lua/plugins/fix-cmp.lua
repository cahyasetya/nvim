-- Fix cmp loading issue
return {
  -- Force load nvim-cmp as early as possible
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 1000,
    cond = function()
      -- This global flag will track whether cmp has been configured
      _G.cmp_configured = _G.cmp_configured or false
      return true
    end,
    config = function()
      -- Avoid configuring twice
      if _G.cmp_configured then return end
      _G.cmp_configured = true
      
      -- Since we ensure cmp is loaded in after/plugin/cmp_preload.lua,
      -- we should be able to require it normally here
      local cmp = require("cmp")
      
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
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
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
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
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
  },
  
  -- Ensure all completion sources are registered AFTER nvim-cmp is loaded
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  },
}