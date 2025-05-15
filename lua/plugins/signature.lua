-- Adds enhanced function signature display when typing
return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    debug = false,
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
    verbose = false,
    bind = true,
    doc_lines = 0,
    max_height = 12,
    max_width = 80,
    wrap = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    floating_window_off_x = 1,
    floating_window_off_y = 0,
    close_timeout = 4000,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter",
    handler_opts = {
      border = "rounded",
    },
    always_trigger = false,
    auto_close_after = nil,
    extra_trigger_chars = {},
    zindex = 200,
    padding = "",
    transparency = nil,
    shadow_blend = 36,
    shadow_guibg = "Black",
    timer_interval = 200,
    toggle_key = nil,
    select_signature_key = nil,
    move_cursor_key = nil,
  },
  config = function(_, opts)
    -- Setup function signature hover
    require("lsp_signature").setup(opts)
    
    -- Make sure it works well with transparency
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd([[highlight LspSignatureActiveParameter guifg=#83d3ff guibg=NONE gui=bold,underline]])
      end,
    })
  end,
}
