-- Mason 工具安装配置
-- 确保所有语言的 LSP、格式化、代码检查工具都已安装

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP Servers
        "lua-language-server", -- Lua
        "pyright", -- Python
        "ruff", -- Python linting/formatting
        "jdtls", -- Java
        "gopls", -- Go
        "rust-analyzer", -- Rust
        "clangd", -- C/C++/Objective-C
        "typescript-language-server", -- TypeScript/JavaScript
        "vtsls", -- TypeScript/JavaScript
        "vue-language-server", -- Vue
        "tailwindcss-language-server", -- Tailwind CSS
        "html-lsp", -- HTML
        "css-lsp", -- CSS
        "json-lsp", -- JSON
        "intelephense", -- PHP
        "omnisharp", -- C#
        -- Formatters
        "prettier", -- JavaScript/TypeScript/HTML/CSS/JSON
        "stylua", -- Lua
        "gofumpt", -- Go formatting
        "goimports", -- Go imports
        "clang-format", -- C/C++
        -- Linters
        "eslint_d", -- JavaScript/TypeScript
        "golangci-lint", -- Go
        -- Debuggers
        "debugpy", -- Python
        "java-debug-adapter", -- Java
        "java-test", -- Java
        "delve", -- Go
        "codelldb", -- C/C++/Rust
        "js-debug-adapter", -- JavaScript/TypeScript
      },
      -- 增加超时时间
      install_timeout = 300,
      -- 限制并发安装数量
      max_concurrent_installers = 2,
    },
  },
}