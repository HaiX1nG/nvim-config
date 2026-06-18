-- 流星魔法拖尾效果
-- 基于 smear-cursor.nvim 的扩展，实现流星/魔法粒子拖尾
-- 不改动原有 rainbow_cursor.lua，独立模块

local M = {}

-- 流星颜色调色板（魔法主题）
local meteor_colors = {
  -- 金色流星
  gold = {
    "#FFD700", "#FFA500", "#FF8C00", "#FF6347", "#FF4500",
    "#FFB347", "#FFE4B5", "#FFF8DC", "#DAA520", "#B8860B",
  },
  -- 冰霜流星
  ice = {
    "#00FFFF", "#00CED1", "#48D1CC", "#40E0D0", "#AFEEEE",
    "#E0FFFF", "#87CEEB", "#87CEFA", "#ADD8E6", "#B0E0E6",
  },
  -- 紫焰流星
  purple = {
    "#E6E6FA", "#DDA0DD", "#DA70D6", "#BA55D3", "#9370DB",
    "#8A2BE2", "#9400D3", "#9932CC", "#8B008B", "#4B0082",
  },
  -- 霓虹流星
  neon = {
    "#FF10F0", "#00FF41", "#00FFFF", "#FF0080", "#FFFF00",
    "#FF4500", "#7FFF00", "#FF1493", "#00FA9A", "#FFD700",
  },
}

-- 当前配置
local current_palette = "gold"
local color_index = 1
local timer = nil
local enabled = false
local sparkle_mode = false -- 是否开启闪烁粒子效果

-- 粒子系统
local particles = {}
local particle_timer = nil

-- 获取当前调色板颜色
local function get_palette()
  return meteor_colors[current_palette] or meteor_colors.gold
end

-- 获取流星颜色（带渐变效果）
local function get_meteor_color(index)
  local palette = get_palette()
  local idx = ((index - 1) % #palette) + 1
  return palette[idx]
end

-- 生成闪烁效果颜色（更亮或更暗）
local function get_sparkle_color(base_color)
  if not sparkle_mode then
    return base_color
  end
  -- 随机微调亮度
  local r = tonumber(base_color:sub(2, 3), 16)
  local g = tonumber(base_color:sub(4, 5), 16)
  local b = tonumber(base_color:sub(6, 7), 16)

  local factor = 0.7 + math.random() * 0.6 -- 0.7 ~ 1.3
  r = math.min(255, math.floor(r * factor))
  g = math.min(255, math.floor(g * factor))
  b = math.min(255, math.floor(b * factor))

  return string.format("#%02X%02X%02X", r, g, b)
end

-- 设置光标颜色（同时设置 smear-cursor）
local function set_meteor_color(color)
  -- 设置真实光标颜色
  vim.api.nvim_set_hl(0, "Cursor", {
    bg = color,
    fg = "#FFFFFF",
    bold = true,
  })

  -- OSC 序列设置终端光标颜色
  local osc_sequence = string.format("\027]12;%s\027\\", color)
  vim.api.nvim_chan_send(vim.v.stderr, osc_sequence)

  -- 设置 smear-cursor 颜色
  local ok, smear_color = pcall(require, "smear_cursor.color")
  if ok and smear_color then
    smear_color.cursor_color = color
  end
end

-- 创建自动命令组
local meteor_augroup = vim.api.nvim_create_augroup("MeteorCursor", { clear = true })

-- 监听 ColorScheme 事件
vim.api.nvim_create_autocmd("ColorScheme", {
  group = meteor_augroup,
  callback = function()
    if enabled then
      local color = get_meteor_color(color_index)
      set_meteor_color(get_sparkle_color(color))
    end
  end,
})

-- 启动流星效果
function M.start(palette_name)
  -- 如果 rainbow_cursor 正在运行，先停止它（避免冲突）
  local ok, rainbow = pcall(require, "rainbow_cursor")
  if ok and rainbow.is_enabled and rainbow.is_enabled() then
    rainbow.stop()
  end

  if timer then
    timer:stop()
    timer:close()
  end

  enabled = true
  current_palette = palette_name or current_palette

  -- 创建定时器，每 80ms 改变一次颜色（比彩虹慢，更有流星感）
  timer = vim.loop.new_timer()
  timer:start(
    0,
    80,
    vim.schedule_wrap(function()
      if enabled then
        color_index = color_index + 1
        local color = get_meteor_color(color_index)
        set_meteor_color(get_sparkle_color(color))
      end
    end)
  )

  local palette_display = current_palette:gsub("^%l", string.upper)
  vim.notify("☄️ 流星拖尾已开启 [" .. palette_display .. "]", vim.log.levels.INFO)
end

-- 停止流星效果
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

  -- 重置终端光标颜色
  vim.api.nvim_chan_send(vim.v.stderr, "\027]112\027\\")

  -- 恢复 smear-cursor 默认颜色
  local ok, smear_color = pcall(require, "smear_cursor.color")
  if ok and smear_color then
    smear_color.cursor_color = nil
  end

  vim.notify("流星拖尾已关闭", vim.log.levels.INFO)
end

-- 切换流星效果
function M.toggle(palette_name)
  if enabled then
    M.stop()
  else
    M.start(palette_name)
  end
end

-- 切换调色板
function M.set_palette(palette_name)
  if meteor_colors[palette_name] then
    current_palette = palette_name
    color_index = 1
    if enabled then
      local palette_display = palette_name:gsub("^%l", string.upper)
      vim.notify("🎨 切换至 " .. palette_display .. " 调色板", vim.log.levels.INFO)
    end
  else
    local available = table.concat(vim.tbl_keys(meteor_colors), ", ")
    vim.notify("未知调色板: " .. palette_name .. "\n可用: " .. available, vim.log.levels.WARN)
  end
end

-- 开关闪烁粒子效果
function M.toggle_sparkle()
  sparkle_mode = not sparkle_mode
  local status = sparkle_mode and "开启" or "关闭"
  vim.notify("✨ 闪烁粒子效果已" .. status, vim.log.levels.INFO)
end

-- 获取当前状态
function M.status()
  local palette_display = current_palette:gsub("^%l", string.upper)
  local sparkle_status = sparkle_mode and "✨开启" or "关闭"
  return string.format("流星拖尾: %s | 调色板: %s | 闪烁: %s",
    enabled and "☄️运行中" or "已停止",
    palette_display,
    sparkle_status)
end

-- 检查是否启用
function M.is_enabled()
  return enabled
end

-- 列出可用调色板
function M.list_palettes()
  local list = {}
  for name, colors in pairs(meteor_colors) do
    table.insert(list, string.format("%s (%d色)", name, #colors))
  end
  vim.notify("可用调色板:\n" .. table.concat(list, "\n"), vim.log.levels.INFO)
end

return M
