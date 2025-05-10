-- Fallback module for nvim-cmp in case everything else fails
return {
  -- Create a minimal API that won't cause errors
  setup = function() end,
  mapping = {
    preset = {
      insert = function() return {} end
    }
  },
  config = {
    sources = function() return {} end
  },
  event = {
    on = function() end
  }
}