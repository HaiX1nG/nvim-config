-- Neo-tree 配置
-- 显示隐藏文件（如 .env）

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,  -- 显示 .env 等隐藏文件
        hide_gitignored = false,  -- 可选：显示 gitignore 的文件
        hide_by_name = {
          -- 可以指定隐藏某些文件
          -- ".git",
          -- "node_modules",
        },
      },
    },
  },
}
