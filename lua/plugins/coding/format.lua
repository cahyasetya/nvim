-- Formatting plugins
return {
  -- Formatting and linting
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format (conform)",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
      },
      format_on_save = function(bufnr)
        -- Only format on save for some filetypes
        local filetype = vim.bo[bufnr].filetype
        if vim.tbl_contains({ "lua", "javascript", "typescript", "json", "html", "css" }, filetype) then
          return { timeout_ms = 500, lsp_fallback = true }
        end
        return false
      end,
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        prettier = {
          prepend_args = { "--tab-width", "2", "--single-quote" },
        },
      },
    },
  },
  
  -- Linting
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {
        lua = { "luacheck" },
        python = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      },
      linters = {
        luacheck = {
          args = {
            "--globals",
            "vim",
            "--no-unused-args",
          },
        },
        eslint_d = {
          args = {
            "--format",
            "json",
            "--no-warn-ignored",
          },
        },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      
      -- Apply custom linter configurations
      for name, config in pairs(opts.linters or {}) do
        if type(config) == "table" and lint.linters[name] then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], config)
        end
      end
      
      -- Create autocmd to lint on events
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
      
      -- Create command to manually trigger linting
      vim.api.nvim_create_user_command("Lint", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}