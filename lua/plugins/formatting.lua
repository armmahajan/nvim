return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          go = { "gofmt" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range" })
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Define linters by filetype (only runs if linter is installed)
      lint.linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      -- Helper to check if linter executable exists
      local function try_lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            return false
          end
          local cmd = linter.cmd
          if type(cmd) == "function" then
            cmd = cmd()
          end
          return cmd and type(cmd) == "string" and vim.fn.executable(cmd) == 1
        end, names)
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      -- Lint on save and text change
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
