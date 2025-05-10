-- Coding plugins index
-- Plugins related to programming and coding

return {
  -- Language support and syntax highlighting
  { import = "plugins.coding.syntax" },

  -- Completion and snippets (consolidated)
  { import = "plugins.coding.cmp" },

  -- Git integration
  { import = "plugins.coding.git" },

  -- LSP configuration
  { import = "plugins.coding.lsp" },

  -- Formatting and linting
  { import = "plugins.coding.format" },
}