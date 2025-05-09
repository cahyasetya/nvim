-- Ghostty integration plugins
-- Plugins specifically for Ghostty terminal integration

return {
  -- Transparency support
  { import = "plugins.ghostty.transparency" },
  
  -- Ghostty-specific optimizations
  { import = "plugins.ghostty.optimizations" },
  
  -- Integration features
  { import = "plugins.ghostty.integration" },
}