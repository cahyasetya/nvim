-- UI plugins index
-- Loads all UI-related plugins

return {
  -- Color schemes and theme
  { import = "plugins.ui.colorscheme" },
  
  -- Status line
  { import = "plugins.ui.statusline" },
  
  -- File explorer
  { import = "plugins.ui.neo-tree" },
  
  -- Dashboard and start screen
  { import = "plugins.ui.dashboard" },
  
  -- Cursor enhancements
  { import = "plugins.ui.cursor" },
  
  -- Window styling
  { import = "plugins.ui.windows" },
  
  -- General UI components
  { import = "plugins.ui.components" },
}