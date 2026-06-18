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
          treesitter_highlighting = true,
          window = {
            border = "rounded",
            winblend = 0,
          },
        },
        -- 补全菜单样式
        menu = {
          border = "rounded",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None,PmenuSel:BlinkCmpMenuSelection",
          draw = {
            columns = {
              { "kind_icon", "label", gap = 1 },
              { "source_name", gap = 1 },
            },
            -- 自定义 kind_icon 组件的高亮
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx) return ctx.kind_icon .. " " end,
                highlight = function(ctx)
                  return {
                    { 0, #ctx.kind_icon + 1, group = "BlinkCmpKind" .. ctx.kind, priority = 20000 },
                  }
                end,
              },
              kind = {
                ellipsis = false,
                width = { fill = true },
                text = function(ctx) return ctx.kind end,
                highlight = function(ctx)
                  return { { 0, #ctx.kind, group = "BlinkCmpKind" .. ctx.kind } }
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx) return ctx.label .. ctx.label_detail end,
                highlight = function(ctx)
                  local label = ctx.label
                  local highlights = {
                    { 0, #label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
                  }
                  if ctx.label_detail then
                    table.insert(highlights, { #label, #label + #ctx.label_detail, group = "BlinkCmpLabelDetail" })
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
              },
            },
          },
        },
        -- 触发设置
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_keyword_insert_on_trigger_character = true,
        },
      },
      -- 签名帮助
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winblend = 0,
        },
      },
      -- 来源配置
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            score_offset = 100,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 90,
          },
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = 80,
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            score_offset = 50,
          },
        },
      },
      -- kind 图标
      appearance = {
        kind_icons = {
          Text = "",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "",
          Variable = "󰀫",
          Class = "󰌗",
          Interface = "󰕘",
          Module = "󰆧",
          Property = "",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "󰕘",
          Keyword = "󰌋",
          Snippet = "󰘌",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "󰕘",
          Constant = "󰏿",
          Struct = "󰌗",
          Event = "󰉒",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
      },
    },
  },
}
