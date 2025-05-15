-- Main plugin index file
-- This file loads all plugin configurations in the proper order

-- Load plugin categories in sequence
local M = {
  -- Disable scrolling plugins that break gg and Shift+G
  { "karb94/neoscroll.nvim", enabled = false },
  { "echasnovski/mini.animate", enabled = false },
  { "gen740/SmoothCursor.nvim", enabled = false },
  
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
  
  -- Our improved plugins
  { import = "plugins.git" },                -- Enhanced Git integration
  { import = "plugins.indent-guides" },      -- Better indent guides
  { import = "plugins.signature" },          -- Function signature hints
  { import = "plugins.scrollbar" },          -- Scrollbar with code minimap
}

return M
