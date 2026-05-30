-- 代码补全配置 - Tab 键直接填入（VSCode/IDEA 风格）
-- 使用 blink.cmp（LazyVim 默认）

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Tab 直接确认填入
        ["<Tab>"] = { "accept", "fallback" },
        -- 上下键切换选项
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        -- Shift+Tab 选择上一项
        ["<S-Tab>"] = { "select_prev", "fallback" },
        -- Ctrl+Space 手动触发补全
        ["<C-Space>"] = { "show", "accept" },
      },
      completion = {
        -- 自动选择第一项
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        -- 文档显示
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      -- 签名帮助
      signature = {
        enabled = true,
      },
    },
  },
}
