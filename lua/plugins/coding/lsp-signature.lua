-- Fix LSP signature conflict with Noice and provide proper configuration
return {
  -- Function signature as you type
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/nvim-cmp", -- Ensure nvim-cmp is loaded first
  },
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    hint_enable = false,
    -- Prevent conflicts with Noice
    doc_lines = 0,
    floating_window = true,
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
    
    -- Only set up signature after checking for Noice
    require("lsp_signature").setup(opts)
    
    -- If Noice is loaded, ensure its signature help is disabled
    if noice_loaded then
      -- Make sure Noice signature help is disabled
      noice.setup({
        lsp = {
          signature = {
            enabled = false,
          },
        },
      })
    end
  end
}
