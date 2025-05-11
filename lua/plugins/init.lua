-- Main plugin index file
-- This file loads all plugin configurations in the proper order

-- Load plugin categories in sequence
local M = {
  -- Core/essential plugins first
  { import = "plugins.editor" },   -- Basic editor functionality
  
  -- UI components
  { import = "plugins.ui" },       -- UI components and themes
  
  -- Coding tools (using the unified file)
  { import = "plugins.coding_unified" },  -- All coding tools in one file
  
  -- LSP configuration
  { import = "plugins.lsp" },      -- LSP configuration
  
  -- Additional tools
  { import = "plugins.tools" },    -- Utilities and extensions
  
  -- Ghostty integration
  { import = "plugins.ghostty" },  -- Ghostty terminal integration
}

return M
