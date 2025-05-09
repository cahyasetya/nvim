-- Simplified transparency config 
return {
  -- Uses our custom implementation in config/transparency.lua
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      if vim.env.TERM_PROGRAM == "ghostty" then
        -- Let our custom transparency module handle things
        -- This is the better alternative to using transparency plugins
        vim.g.ghostty_transparency_enabled = true
        
        -- Ensure transparency settings are properly loaded
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            -- Only if transparency is enabled
            if vim.g.transparent_enabled then
              -- Apply transparency settings
              pcall(function() 
                require("config.transparency").enable_transparency() 
              end)
            end
          end
        })
      end
    end
  },
}