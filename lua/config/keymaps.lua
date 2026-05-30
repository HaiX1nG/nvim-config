-- Keymaps 配置 - 针对 Kitty 终端优化，使用 Command 键
-- Kitty 支持将 Command 键映射为 Super 键

-- ========================================
-- Command 键映射配置
-- ========================================
-- 在 Kitty 中，Command 键可以映射为 Super 键
-- 使用 <D-...> 表示 Command 组合键

local keymaps = {
  -- ========================================
  -- 文件操作（Command 键 - macOS 风格）
  -- ========================================

  { "<D-s>", "<cmd>write<cr>", desc = "Save File (⌘S)" },
  { "<D-w>", "<cmd>bdelete<cr>", desc = "Close Buffer (⌘W)" },
  { "<D-q>", "<cmd>quit<cr>", desc = "Quit (⌘Q)" },
  { "<D-n>", "<cmd>enew<cr>", desc = "New File (⌘N)" },
  { "<D-o>", "<cmd>Telescope find_files<cr>", desc = "Open File (⌘O)" },
  { "<D-S-s>", "<cmd>saveas<cr>", desc = "Save As (⌘⇧S)" },

  -- ========================================
  -- 编辑操作（Command 键 - macOS 风格）
  -- ========================================

  -- 复制粘贴（系统剪贴板）- 使用 Ctrl 键避免与 Kitty 冲突
  { "<C-c>", '"+y', desc = "Copy", mode = { "n", "v" } },
  { "<C-v>", '"+p', desc = "Paste", mode = { "n", "v" } },
  { "<C-x>", '"+x', desc = "Cut", mode = { "n", "v" } },
  { "<C-a>", "ggVG", desc = "Select All" },

  -- 撤销重做 - 使用 Ctrl 键
  { "<C-z>", "u", desc = "Undo" },
  { "<C-r>", "<cmd>redo<cr>", desc = "Redo" },

  -- 查找替换
  { "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in File (⌘F)" },
  { "<D-g>", "<cmd>Telescope live_grep<cr>", desc = "Find in Project (⌘G)" },
  { "<D-r>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename (⌘R)" },

  -- ========================================
  -- 窗口管理（Command 键）
  -- ========================================

  -- 新建窗口/分屏
  { "<D-\\>", "<cmd>vsplit<cr>", desc = "Split Vertically (⌘\\)" },
  { "<D-->", "<cmd>split<cr>", desc = "Split Horizontally (⌘-)" },

  -- 窗口切换（Command+数字）
  { "<D-1>", "<cmd>Neotree toggle<cr>", desc = "Toggle File Tree (⌘1)" },
  { "<D-2>", "<cmd>Neotree focus<cr>", desc = "Focus File Tree (⌘2)" },
  { "<D-3>", "<cmd>terminal<cr>", desc = "Toggle Terminal (⌘3)" },

  -- 标签页（Command+T）
  { "<D-t>", "<cmd>tabnew<cr>", desc = "New Tab (⌘T)" },
  { "<D-[>", "<cmd>tabprevious<cr>", desc = "Previous Tab (⌘[)" },
  { "<D-]>", "<cmd>tabnext<cr>", desc = "Next Tab (⌘])" },
  { "<D-w>", "<cmd>tabclose<cr>", desc = "Close Tab (⌘W)" },

  -- ========================================
  -- 导航（Command 键）
  -- ========================================

  { "<D-b>", "<cmd>Telescope buffers<cr>", desc = "Show Buffers (⌘B)" },
  { "<D-e>", "<cmd>Neotree toggle<cr>", desc = "Show Explorer (⌘E)" },
  { "<D-p>", "<cmd>Telescope find_files<cr>", desc = "Quick Open (⌘P)" },
  { "<D-0>", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", desc = "Show Symbols (⌘0)" },

  -- 跳转到定义/引用 (由 lspsaga 处理)
  -- { "<D-d>", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition (⌘D)" },
  -- { "<D-u>", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Find Usages (⌘U)" },

  -- ========================================
  -- 代码操作（Command 键 - 由 lspsaga 处理，使用 Leader 键避免冲突）
  -- ========================================

  -- { "<D-.>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Quick Fix (⌘.)" },
  -- { "<D-r>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename (⌘R)" },
  -- { "<D-k>", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show Hover (⌘K)" },
  { "<D-/>", "gcc", desc = "Toggle Comment (⌘/)", mode = "n" },
  { "<D-/>", "gc", desc = "Toggle Comment (⌘/)", mode = "v" },

  -- 格式化
  { "<D-i>", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format Document (⌘I)" },
  -- Hover 由 lspsaga 处理: <D-k>

  -- ========================================
  -- LSP 增强（lspsaga）- 使用 Leader 键避免与 Kitty 冲突
  -- ========================================
  { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Quick Fix" },
  { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
  { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to Definition" },
  { "gr", "<cmd>Lspsaga finder<cr>", desc = "Find Usages" },
  { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Show Hover" },
  { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous Diagnostic" },
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" },
  { "<leader>xd", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show Line Diagnostics" },

  -- ========================================
  -- 调试（Command+Shift）
  -- ========================================

  { "<D-S-b>", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint (⌘⇧B)" },
  { "<D-S-r>", "<cmd>lua require('dap').continue()<cr>", desc = "Start Debugging (⌘⇧R)" },
  { "<D-S-s>", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over (⌘⇧S)" },
  { "<D-S-i>", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into (⌘⇧I)" },
  { "<D-S-o>", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out (⌘⇧O)" },

  -- ========================================
  -- Git（Command+Shift）
  -- ========================================

  { "<D-S-g>", "<cmd>LazyGit<cr>", desc = "Open LazyGit (⌘⇧G)" },
  { "<D-S-c>", "<cmd>Git commit<cr>", desc = "Git Commit (⌘⇧C)" },
  { "<D-S-p>", "<cmd>Git push<cr>", desc = "Git Push (⌘⇧P)" },

  -- ========================================
  -- 终端（Command+Shift）
  -- ========================================

  { "<D-S-t>", "<cmd>terminal<cr>", desc = "New Terminal (⌘⇧T)" },
  { "<D-S-n>", "<cmd>enew<cr>", desc = "New File (⌘⇧N)" },
}

-- 应用键位映射
for _, map in ipairs(keymaps) do
  local modes = map.mode or "n"
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, map[1], map[2], {
      desc = map.desc,
      remap = map.remap or false,
      silent = map.silent ~= false,
    })
  end
end

-- ========================================
-- 插入模式下的快捷键
-- ========================================

-- 插入模式下的粘贴
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Paste" })

-- 插入模式下的撤销
vim.keymap.set("i", "<C-z>", '<C-o>u', { desc = "Undo" })

-- ========================================
-- 命令模式下的快捷键
-- ========================================

-- 命令模式粘贴
vim.keymap.set("c", "<C-v>", "<C-r>+", { desc = "Paste" })

-- ========================================
-- 系统剪贴板配置（macOS + Kitty）
-- ========================================

if vim.fn.has("macunix") == 1 then
  -- 设置剪贴板
  vim.opt.clipboard = "unnamedplus"

  -- macOS 特定：使用 pbcopy/pbpaste
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end

-- ========================================
-- 保留的 Leader 键快捷键
-- ========================================
-- Space 键的快捷键仍然可用

-- ========================================
-- 键盘延迟优化
-- ========================================

vim.opt.timeoutlen = 300  -- 等待键位序列的时间（毫秒）
vim.opt.ttimeoutlen = 10  -- 等待键位代码的时间（毫秒）
