-- LazyVim 官方配置
-- https://www.lazyvim.org

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- 使用 SSH 克隆 lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "everforest", "tokyonight", "habamax" },
  },
  checker = {
    enabled = false,
  },
  performance = {
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
  -- Git 配置 - 使用 SSH 方式
  git = {
    timeout = 600, -- 10分钟超时
  },
})

-- 启动彩虹光标效果（默认）
-- 如果想用流星效果，注释掉下面这行，取消注释 meteor_cursor 那行
vim.schedule(function()
  require("rainbow_cursor").start()
end)

-- 启动流星魔法拖尾效果（可选，4种调色板: gold/ice/purple/neon）
-- vim.schedule(function()
--   require("meteor_cursor").start("gold")
-- end)
