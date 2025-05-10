-- Ensure nvim-cmp is loaded properly 
local nvim_cmp_path = vim.fn.stdpath("data") .. "/lazy/nvim-cmp"

-- Check if the plugin directory exists
if vim.fn.isdirectory(nvim_cmp_path) == 1 then
  -- Add plugin's lua directory to runtime path
  local plugin_lua_path = nvim_cmp_path .. "/lua"
  package.path = package.path .. ";" .. plugin_lua_path .. "/?.lua;" .. plugin_lua_path .. "/?/init.lua"
  
  -- Directly add the module to package.loaded if it doesn't exist
  if not package.loaded.cmp then
    -- Try loading with pcall for safety
    local ok, module = pcall(function() 
      return loadfile(plugin_lua_path .. "/cmp.lua")() or
             loadfile(plugin_lua_path .. "/cmp/init.lua")()
    end)
    
    if ok and module then
      package.loaded.cmp = module
      vim.notify("Successfully preloaded nvim-cmp", vim.log.levels.INFO)
    else
      vim.notify("Failed to preload nvim-cmp: " .. (module or "unknown error"), vim.log.levels.ERROR)
    end
  end
end