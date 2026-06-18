-- 彩虹拖尾效果 - 基于 smear-cursor.nvim 的扩展
-- 通过定时改变 Cursor 高亮颜色和 smear-cursor 颜色实现彩虹效果

local M = {}

-- 彩虹色相环颜色 (12色)
local rainbow_colors = {
  "#FF0000", -- 红
  "#FF4500", -- 橙红
  "#FFA500", -- 橙
  "#FFD700", -- 金黄
  "#00FF00", -- 绿
  "#00CED1", -- 青
  "#0000FF", -- 蓝
  "#4169E1", -- 皇家蓝
  "#8A2BE2", -- 紫
  "#9400D3", -- 深紫
  "#FF1493", -- 深粉
  "#FF69B4", -- 热粉
}

local color_index = 1
local timer = nil
local enabled = false

-- HSL 转 RGB 辅助函数
local function hsl_to_rgb(h, s, l)
  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local function hue2rgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1/6 then return p + (q - p) * 6 * t end
      if t < 1/2 then return q end
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
      return p
    end
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)
  end
  return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

-- 生成彩虹色 (动态)
local function get_rainbow_color()
  local hue = color_index / 360
  local r, g, b = hsl_to_rgb(hue, 1, 0.5)
  color_index = (color_index + 5) % 360
  return string.format("#%02X%02X%02X", r, g, b)
end

-- 设置光标颜色（同时设置真实光标和 smear-cursor）
local function set_cursor_color(color)
  -- 设置真实光标颜色（nvim 内部）
  vim.api.nvim_set_hl(0, "Cursor", {
    bg = color,
    fg = "#FFFFFF",
    bold = true,
  })

  -- 通过 OSC 序列设置终端光标颜色（WezTerm/Kitty 支持）
  -- OSC 12: 设置光标颜色
  local osc_sequence = string.format("\027]12;%s\027\\", color)
  vim.api.nvim_chan_send(vim.v.stderr, osc_sequence)

  -- 设置 smear-cursor 颜色
  local ok, smear_color = pcall(require, "smear_cursor.color")
  if ok and smear_color then
    smear_color.cursor_color = color
  end
end

-- 创建自动命令组
local rainbow_augroup = vim.api.nvim_create_augroup("RainbowCursor", { clear = true })

-- 监听 ColorScheme 事件，防止主题覆盖光标颜色
vim.api.nvim_create_autocmd("ColorScheme", {
  group = rainbow_augroup,
  callback = function()
    if enabled then
      -- 重新应用当前彩虹颜色
      local color = get_rainbow_color()
      set_cursor_color(color)
    end
  end,
})

-- 启动彩虹效果
function M.start()
  if timer then
    timer:stop()
    timer:close()
  end

  enabled = true

  -- 创建定时器，每 50ms 改变一次颜色
  timer = vim.loop.new_timer()
  timer:start(
    0,
    50,
    vim.schedule_wrap(function()
      if enabled then
        local color = get_rainbow_color()
        set_cursor_color(color)
      end
    end)
  )

  vim.notify("🌈 彩虹拖尾已开启", vim.log.levels.INFO)
end

-- 停止彩虹效果
function M.stop()
  enabled = false

  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end

  -- 恢复默认光标颜色
  vim.api.nvim_set_hl(0, "Cursor", {
    bg = "#d0d0d0",
    fg = "#000000",
  })

  -- 通过 OSC 序列重置终端光标颜色
  vim.api.nvim_chan_send(vim.v.stderr, "\027]112\027\\")

  -- 恢复 smear-cursor 默认颜色
  local ok, smear_color = pcall(require, "smear_cursor.color")
  if ok and smear_color then
    smear_color.cursor_color = nil
  end

  vim.notify("彩虹拖尾已关闭", vim.log.levels.INFO)
end

-- 切换彩虹效果
function M.toggle()
  if enabled then
    M.stop()
  else
    M.start()
  end
end

-- 检查是否启用
function M.is_enabled()
  return enabled
end

return M
