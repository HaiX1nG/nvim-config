-- Lazy.nvim 配置 - 使用 SSH 方式下载
-- 解决 GitHub 无法连接的问题

return {
  {
    "folke/lazy.nvim",
    opts = {
      -- Git 超时设置（秒）
      git = {
        timeout = 600, -- 10分钟超时
      },

      -- 安装设置
      install = {
        missing = true,
        colorscheme = { "catppuccin", "habamax" },
      },

      -- 性能优化
      performance = {
        cache = {
          enabled = true,
        },
        reset_packpath = true,
        rtp = {
          disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },

      -- 并发控制
      concurrency = 10,

      -- 检查更新
      checker = {
        enabled = false,
        notify = false,
      },
    },
  },
}
