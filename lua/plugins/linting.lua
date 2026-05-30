-- 代码检查配置
-- 使用 nvim-lint 提供代码检查支持

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },

        -- Python
        python = { "ruff", "pylint" },

        -- Go
        go = { "golangcilint" },

        -- PHP
        php = { "phpcs" },

        -- C/C++/Objective-C
        c = { "clangtidy" },
        cpp = { "clangtidy" },
        objc = { "clangtidy" },
        objcpp = { "clangtidy" },

        -- Shell
        sh = { "shellcheck" },
        bash = { "shellcheck" },

        -- Lua
        lua = { "luacheck" },
      },
    },
  },
}
