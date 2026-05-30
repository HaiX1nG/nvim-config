-- Treesitter 配置
-- 使用 kkgithub 镜像加速下载

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- 基础语言
        "lua",
        "vim",
        "vimdoc",
        "query",
        -- Web 开发
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "json5",
        "jsonc",
        -- 框架
        "vue",
        -- 后端语言
        "python",
        "java",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "rust",
        "c",
        "cpp",
        "c_sharp",
        "objc",
        "php",
        -- 脚本语言
        "bash",
        "zsh",
        -- 标记语言
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
        -- 其他
        "regex",
        "comment",
        "diff",
      },
      -- 安装设置
      sync_install = false,
      auto_install = true,
      install = {
        prefer_git = true,
        -- 使用 kkgithub 镜像
        git_address_format = "https://kkgithub.com/%s",
        compilers = { "gcc", "cc", "clang", "cl" },
      },
      -- 高亮设置
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- 增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-backspace>",
        },
      },
      -- 缩进
      indent = {
        enable = true,
      },
    },
  },
}