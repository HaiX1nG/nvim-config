-- 代码格式化配置
-- 使用 conform.nvim 提供格式化支持

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- Lua
        lua = { "stylua" },

        -- Python
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff", bufnr).available then
            return { "ruff" }
          end
          return { "isort", "black" }
        end,

        -- JavaScript/TypeScript
        javascript = { "prettier", "prettierd", stop_after_first = true },
        javascriptreact = { "prettier", "prettierd", stop_after_first = true },
        typescript = { "prettier", "prettierd", stop_after_first = true },
        typescriptreact = { "prettier", "prettierd", stop_after_first = true },
        vue = { "prettier", "prettierd", stop_after_first = true },
        html = { "prettier", "prettierd", stop_after_first = true },
        css = { "prettier", "prettierd", stop_after_first = true },
        scss = { "prettier", "prettierd", stop_after_first = true },
        json = { "prettier", "prettierd", stop_after_first = true },
        jsonc = { "prettier", "prettierd", stop_after_first = true },
        yaml = { "prettier", "prettierd", stop_after_first = true },
        markdown = { "prettier", "prettierd", stop_after_first = true },

        -- Go
        go = { "goimports", "gofumpt" },

        -- Rust
        rust = { "rustfmt" },

        -- C/C++/Objective-C
        c = { "clang-format" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },

        -- PHP
        php = { "php_cs_fixer" },

        -- C#
        cs = { "csharpier" },
      },

      -- 格式化选项
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}