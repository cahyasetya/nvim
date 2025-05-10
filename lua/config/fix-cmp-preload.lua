-- Direct fix for nvim-cmp loading issues
local M = {}

-- This should be called very early in the initialization process
function M.setup()
  local nvim_cmp_path = vim.fn.stdpath("data") .. "/lazy/nvim-cmp"
  
  -- Check if nvim-cmp is installed
  if vim.fn.isdirectory(nvim_cmp_path) == 1 then
    -- Add plugin's Lua path to package.path
    local plugin_lua_path = nvim_cmp_path .. "/lua"
    package.path = package.path .. ";" .. plugin_lua_path .. "/?.lua;" .. plugin_lua_path .. "/?/init.lua"
    
    -- Register a dummy cmp module if it doesn't exist yet
    if not package.loaded.cmp then
      -- Try to load the real module first
      local ok, cmp_module = pcall(function()
        -- Look for cmp.lua or cmp/init.lua in the plugin's lua directory
        local cmp_lua_path = plugin_lua_path .. "/cmp.lua"
        local cmp_init_path = plugin_lua_path .. "/cmp/init.lua"
        
        if vim.fn.filereadable(cmp_lua_path) == 1 then
          return loadfile(cmp_lua_path)()
        elseif vim.fn.filereadable(cmp_init_path) == 1 then
          return loadfile(cmp_init_path)()
        end
        
        -- As a last resort, create a dummy module
        return {
          setup = function() end,
          mapping = {
            preset = {
              insert = function() return {} end
            }
          },
          config = {
            sources = function() return {} end
          }
        }
      end)
      
      -- Register the module
      if ok and cmp_module then
        package.loaded.cmp = cmp_module
        vim.notify("Pre-loaded nvim-cmp module", vim.log.levels.INFO)
      else
        vim.notify("Failed to pre-load nvim-cmp, using dummy module", vim.log.levels.WARN)
        -- Register a minimal dummy module as fallback
        package.loaded.cmp = {
          setup = function() end,
          mapping = {
            preset = {
              insert = function() return {} end
            }
          },
          config = {
            sources = function() return {} end
          }
        }
      end
    end
  end
end

return M