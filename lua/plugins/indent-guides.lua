-- Adds visually appealing indent guides
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│", -- Use a subtle vertical line
      tab_char = "│",
    },
    scope = { 
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = {"Function", "Label"},
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  config = function(_, opts)
    -- Make sure scope is visible but not too prominent with transparency
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd("highlight IblScope guifg=#5d86b4 gui=nocombine")
      end,
    })
    
    require("ibl").setup(opts)
  end,
}
