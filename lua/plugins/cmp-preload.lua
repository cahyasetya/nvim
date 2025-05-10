-- This file ensures nvim-cmp is loaded very early
return {
  -- Force nvim-cmp to load at startup
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    lazy = false,
    priority = 10000, -- Highest priority possible
  },
  
  -- Also load the LuaSnip engine early
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    lazy = false,
    priority = 9999,
  },
}