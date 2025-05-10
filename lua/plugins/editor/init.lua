-- Editor plugins index
-- Contains basic editor functionality plugins

return {
  -- Navigation and file management
  { import = "plugins.editor.navigation" },

  -- Search and selection
  { import = "plugins.editor.search" },

  -- Telescope configuration (consolidated)
  { import = "plugins.editor.telescope" },

  -- Performance optimizations
  { import = "plugins.editor.performance" },

  -- Text operations
  { import = "plugins.editor.text" },

  -- Terminal integration
  { import = "plugins.editor.terminal" },
}