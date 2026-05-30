-- LazyVim 语言支持配置
-- 根据 LazyVim 官方文档配置: https://www.lazyvim.org

return {
  -- ====================
  -- 代码补全引擎 (二选一)
  -- ====================

  -- 选项1: blink.cmp (推荐, 更快)
  { import = "lazyvim.plugins.extras.coding.blink" },

  -- 选项2: nvim-cmp (传统, 兼容性好)
  -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },

  -- ====================
  -- 编程语言支持
  -- ====================

  -- Java
  { import = "lazyvim.plugins.extras.lang.java" },

  -- Python
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Lua (Neovim 配置开发)
  -- LazyVim 默认已支持 Lua, 无需额外配置

  -- JavaScript/TypeScript/React
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- JSON
  { import = "lazyvim.plugins.extras.lang.json" },

  -- Vue
  { import = "lazyvim.plugins.extras.lang.vue" },

  -- Tailwind CSS
  { import = "lazyvim.plugins.extras.lang.tailwind" },

  -- Go
  { import = "lazyvim.plugins.extras.lang.go" },

  -- Rust
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- C/C++
  { import = "lazyvim.plugins.extras.lang.clangd" },

  -- C# (.NET)
  { import = "lazyvim.plugins.extras.lang.dotnet" },

  -- PHP
  { import = "lazyvim.plugins.extras.lang.php" },

  -- ====================
  -- HTML/CSS 支持
  -- ====================

  -- HTML/CSS 由 treesitter 和 LSP 自动支持
  -- 通过 emmet 提供更好的 HTML/CSS 体验
  {
    "olrtg/nvim-emmet",
    ft = { "html", "css", "scss", "sass", "less", "vue", "jsx", "tsx", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_mode = "n"
      vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  },

  -- ====================
  -- 格式化和代码检查
  -- ====================

  -- conform.nvim 格式化
  { import = "lazyvim.plugins.extras.formatting.conform" },

  -- nvim-lint 代码检查
  { import = "lazyvim.plugins.extras.linting.nvim-lint" },
}
