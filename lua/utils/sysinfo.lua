local M = {}

-- 缓存数据，每2秒刷新一次
local sys_info = { cpu = 0, mem = 0, last = 0 }

-- 根据CPU负载返回对应颜色
function M.cpu_color(cpu)
  if cpu > 80 then
    return "#ff6b6b" -- 高负载红色
  elseif cpu > 50 then
    return "#feca57" -- 中负载黄色
  else
    return "#1dd1a1" -- 低负载绿色
  end
end

-- 根据内存占用返回对应颜色
function M.mem_color(mem)
  if mem > 500 then
    return "#ff6b6b"
  elseif mem > 200 then
    return "#feca57"
  else
    return "#54a0ff"
  end
end

function M.system_info()
  local now = vim.loop.now()
  if now - sys_info.last < 2000 then
    return string.format("CPU:%.1f MEM:%dMB", sys_info.cpu, sys_info.mem)
  end

  local handle = io.popen("ps -o %cpu=,rss= -p " .. vim.fn.getpid())
  if not handle then
    return ""
  end
  local result = handle:read("*a")
  handle:close()

  local cpu, mem_kb = result:match("([%d%.]+)%s+([%d]+)")
  if cpu and mem_kb then
    sys_info.cpu = tonumber(cpu)
    sys_info.mem = math.floor(tonumber(mem_kb) / 1024)
    sys_info.last = now
    return string.format("CPU:%.1f MEM:%dMB", sys_info.cpu, sys_info.mem)
  end
  return ""
end

return M
