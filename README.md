# Neovim + LazyVim 配置

基于 [LazyVim](https://www.lazyvim.org) 的 Neovim 配置，针对 macOS + Kitty 终端优化，提供类 VSCode 的快捷键体验。

> **注意**：本配置使用 `<D-...>`（Command 键）映射，需要 Kitty 终端将 Command 键映射为 Super 键才能生效。

---

## 目录

- [特性概览](#特性概览)
- [支持的语言](#支持的语言)
- [安装](#安装)
- [快捷键参考](#快捷键参考)
  - [文件操作](#文件操作)
  - [编辑操作](#编辑操作)
  - [查找替换](#查找替换)
  - [窗口管理](#窗口管理)
  - [标签页 / Buffer](#标签页--buffer)
  - [导航](#导航)
  - [代码操作](#代码操作)
  - [LSP 操作](#lsp-操作)
  - [调试](#调试)
  - [Git 操作](#git-操作)
  - [终端](#终端)
  - [代码补全](#代码补全)
  - [Telescope 搜索](#telescope-搜索)
  - [折叠](#折叠)
  - [书签](#书签)
  - [会话管理](#会话管理)
  - [其他](#其他)
- [配置结构](#配置结构)
- [插件列表](#插件列表)

---

## 特性概览

| 特性 | 插件 |
|------|------|
| 代码补全 | blink.cmp |
| 语法高亮 | Treesitter |
| LSP 支持 | nvim-lspconfig + lspsaga |
| 代码格式化 | conform.nvim |
| 代码检查 | nvim-lint |
| 调试支持 | nvim-dap |
| 测试支持 | neotest |
| Git 集成 | gitsigns + LazyGit |
| 文件浏览器 | neo-tree |
| 模糊查找 | Telescope |
| 主题 | TokyoNight |
| 光标拖尾 | smear-cursor.nvim |
| 彩虹光标 | rainbow_cursor.lua |

---

## 支持的语言

- **Java** (jdtls)
- **Go** (gopls)
- **Rust** (rust-analyzer)
- **C/C++** (clangd)
- **Objective-C** (clangd)
- **C#** (omnisharp)
- **HTML/CSS** (html-lsp, css-lsp, tailwindcss)
- **JavaScript/TypeScript** (vtsls)
- **React** (vtsls)
- **Vue** (vue-language-server)
- **PHP** (intelephense)
- **Lua** (lua-language-server)
- **Python** (pyright, ruff)
- **Shell** (bashls)

---

## 安装

### 前置依赖

- Neovim >= 0.10.0
- Git
- Node.js
- Python3
- [Nerd Font](https://www.nerdfonts.com/)（用于图标显示）
- Kitty 终端（推荐，支持 Command 键映射）

### 安装步骤

1. 备份现有配置（如有）：
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. 克隆本仓库：
   ```bash
   git clone https://github.com/HaiX1nG/nvim-config.git ~/.config/nvim
   ```

3. 首次启动 Neovim，LazyVim 会自动安装所有插件：
   ```bash
   nvim
   ```

4. 安装 LSP 服务器和工具：
   ```
   :Mason
   ```

5. （可选）配置 Kitty 支持 Command 键映射：
   在 `~/.config/kitty/kitty.conf` 中添加：
   ```
   macos_option_as_alt no
   map cmd+1 send_text all \x1b[1;3P
   ```

---

## 快捷键参考

> `⌘` = Command 键 | `⌃` = Control 键 | `⇧` = Shift 键 | `⌥` = Option 键
>
> `<D-...>` 表示 Command 键组合，`<C-...>` 表示 Control 键组合，`<S-...>` 表示 Shift 键组合，`<leader>` = `Space`（空格键）

### 文件操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ S` | `<D-s>` | 保存文件 |
| `⌘ ⇧ S` | `<D-S-s>` | 另存为 |
| `⌘ W` | `<D-w>` | 关闭 Buffer |
| `⌘ Q` | `<D-q>` | 退出 Neovim |
| `⌘ N` | `<D-n>` | 新建文件 |
| `⌘ O` | `<D-o>` | 打开文件（Telescope） |

### 编辑操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌃ C` | `<C-c>` | 复制（系统剪贴板） |
| `⌃ V` | `<C-v>` | 粘贴（系统剪贴板） |
| `⌃ X` | `<C-x>` | 剪切（系统剪贴板） |
| `⌃ A` | `<C-a>` | 全选 |
| `⌃ Z` | `<C-z>` | 撤销 |
| `⌃ ⇧ Z` | `<C-S-z>` | 重做 |
| `⌃ Y` | `<C-y>` | 重做（备选） |
| `⌘ /` | `<D-/>` | 切换注释 |

### 查找替换

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ F` | `<D-f>` | 在当前文件中查找 |
| `⌘ G` | `<D-g>` | 在项目全局搜索 |
| `⌘ H` | `<D-h>` | 搜索替换（GrugFar） |
| `⌘ R` | `<D-r>` | 重命名符号 |

### 窗口管理

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ \` | `<D-\>` | 垂直分屏 |
| `⌘ -` | `<D-->` | 水平分屏 |

### 标签页 / Buffer

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ T` | `<D-t>` | 新建标签页 |
| `⌘ [` | `<D-[>` | 上一个标签页 |
| `⌘ ]` | `<D-]>` | 下一个标签页 |
| `⌘ 1` ~ `⌘ 5` | `<D-1>` ~ `<D-5>` | 切换到对应 Buffer |
| `⌘ ⇧ T` | `<D-S-t>` | 关闭其他 Buffer |

### 导航

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ B` | `<D-b>` | 显示 Buffer 列表 |
| `⌘ E` | `<D-e>` | 文件浏览器（Neo-tree） |
| `⌘ P` | `<D-p>` | 快速打开文件 |
| `⌘ 0` | `<D-0>` | 显示文档符号 |
| `⌘ G` | `<D-g>` | 跳转到指定行（Flash） |

### 代码操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ I` | `<D-i>` | 格式化文档 |
| `⌘ .` | `<D-.>` | 快速修复（Code Action） |
| `⌘ ⇧ B` | `<D-S-b>` | 切换断点 |
| `⌘ ⇧ R` | `<D-S-r>` | 开始调试 |
| `⌘ ⇧ S` | `<D-S-s>` | 单步跳过 |
| `⌘ ⇧ I` | `<D-S-i>` | 单步进入 |
| `⌘ ⇧ O` | `<D-S-o>` | 单步跳出 |
| `⌘ ⇧ G` | `<D-S-g>` | 打开 LazyGit |
| `⌘ ⇧ C` | `<D-S-c>` | Git Commit |
| `⌘ ⇧ P` | `<D-S-p>` | Git Push |
| `⌘ ⇧ T` | `<D-S-t>` | 新建终端 |
| `⌘ ⇧ N` | `<D-S-n>` | 新建文件 |
| `⌘ ⇧ M` | `<D-S-m>` | 切换迷你地图 |

### LSP 操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `gd` | `gd` | 跳转到定义（Lspsaga） |
| `gr` | `gr` | 查找引用（Lspsaga） |
| `K` | `K` | 显示悬停文档（Lspsaga） |
| `[d` | `[d` | 上一个诊断 |
| `]d` | `]d` | 下一个诊断 |
| `<leader> ca` | `<leader>ca` | Code Action（Lspsaga） |
| `<leader> rn` | `<leader>rn` | 重命名（Lspsaga） |
| `<leader> xd` | `<leader>xd` | 显示当前行诊断 |
| `<leader> uh` | `<leader>uh` | 切换 Inlay Hints |

### 调试

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader> dB` | `<leader>dB` | 条件断点 |
| `<leader> db` | `<leader>db` | 切换断点 |
| `<leader> dc` | `<leader>dc` | 继续执行 |
| `<leader> di` | `<leader>di` | 单步进入 |
| `<leader> do` | `<leader>do` | 单步跳出 |
| `<leader> dO` | `<leader>dO` | 单步跳过 |
| `<leader> dg` | `<leader>dg` | 跳转到行（不执行） |
| `<leader> dr` | `<leader>dr` | 切换 REPL |
| `<leader> dt` | `<leader>dt` | 终止调试 |

### Git 操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader> gg` | `<leader>gg` | 打开 LazyGit |
| `]h` | `]h` | 下一个 Git Hunk |
| `[h` | `[h` | 上一个 Git Hunk |

### 终端

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ \`` | `<D-\`` | 切换终端（ToggleTerm） |
| `<leader> tf` | `<leader>tf` | 浮动终端 |
| `<leader> th` | `<leader>th` | 水平终端 |
| `<leader> tv` | `<leader>tv` | 垂直终端 |

### 代码补全

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `Tab` | `<Tab>` | 确认并填入补全 |
| `↑ / ↓` | `<Up> / <Down>` | 选择上一个/下一个选项 |
| `⇧ Tab` | `<S-Tab>` | 选择上一个选项 |
| `⌃ Space` | `<C-Space>` | 手动触发补全 |

### Telescope 搜索

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `⌘ P` | `<D-p>` | 查找文件 |
| `⌘ O` | `<D-o>` | 最近文件 |
| `⌘ F` | `<D-f>` | 当前文件内查找 |
| `⌘ G` | `<D-g>` | 全局搜索（Live Grep） |
| `⌘ B` | `<D-b>` | Buffer 列表 |
| `⌘ /` | `<D-/>` | 全局搜索 |
| `⌘ ⇧ P` | `<D-S-p>` | 命令面板 |
| `<leader> ff` | `<leader>ff` | 查找文件 |
| `<leader> fr` | `<leader>fr` | 最近文件 |
| `<leader> fb` | `<leader>fb` | Buffer 列表 |
| `<leader> fg` | `<leader>fg` | Live Grep |
| `<leader> fw` | `<leader>fw` | 查找当前单词 |
| `<leader> fh` | `<leader>fh` | 帮助标签 |
| `<leader> fk` | `<leader>fk` | 快捷键列表 |
| `<leader> fm` | `<leader>fm` | 标记列表 |
| `<leader> ft` | `<leader>ft` | TODO 列表 |
| `<leader> fp` | `<leader>fp` | 项目列表 |

### 折叠

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `zR` | `zR` | 展开所有折叠 |
| `zM` | `zM` | 折叠所有 |
| `zr` | `zr` | 展开折叠（保留部分） |
| `zm` | `zm` | 折叠部分 |
| `zp` | `zp` | 预览折叠内容 |

### 书签

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `mm` | `mm` | 切换书签 |
| `mi` | `mi` | 添加书签注释 |
| `mc` | `mc` | 清除当前文件书签 |
| `mn` | `mn` | 下一个书签 |
| `mp` | `mp` | 上一个书签 |
| `ml` | `ml` | 列出书签 |

### 会话管理

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader> qs` | `<leader>qs` | 恢复会话 |
| `<leader> ql` | `<leader>ql` | 恢复上一个会话 |
| `<leader> qd` | `<leader>qd` | 停止自动保存会话 |
| `<leader> qS` | `<leader>qS` | 保存会话 |

### 其他

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader> rc` | `<leader>rc` | 切换彩虹光标 |
| `<leader> cs` | `<leader>cs` | 切换代码大纲（Outline） |
| `<leader> um` | `<leader>um` | 切换迷你地图 |
| `<leader> p` | `<leader>p` | 剪贴板历史（Yanky） |
| `gs` | `gs` | Flash 快速跳转 |
| `gS` | `gS` | Flash Treesitter 跳转 |
| `g<C-a>` | `g<C-a>` | 智能增加（Dial） |
| `g<C-x>` | `g<C-x>` | 智能减少（Dial） |
| `<leader> xx` | `<leader>xx` | 诊断列表（Trouble） |
| `<leader> xX` | `<leader>xX` | 当前 Buffer 诊断 |
| `<leader> sp` | `<leader>sp` | 打开 Spectre 搜索替换 |

---

## 配置结构

```
~/.config/nvim/
├── init.lua                    # 入口文件（LazyVim 配置）
├── lazy-lock.json             # 插件锁定文件
├── lazyvim.json               # LazyVim 配置
├── stylua.toml                # Lua 格式化配置
├── LICENSE                    # 许可证
├── .gitignore                 # Git 忽略配置
└── lua/
    ├── config/
    │   ├── autocmds.lua       # 自动命令（自动保存、文件类型识别）
    │   ├── diagnostics.lua    # 诊断配置（浮窗自动显示）
    │   ├── keymaps.lua        # 键位映射（Command 键、系统剪贴板）
    │   └── options.lua        # 选项配置
    ├── plugins/
    │   ├── cmp.lua            # 代码补全（blink.cmp）
    │   ├── custom.lua         # 自定义插件（主题、光标、图标等）
    │   ├── dap.lua            # 调试配置（nvim-dap）
    │   ├── editor.lua         # 编辑器增强（自动括号、Git、缩进等）
    │   ├── formatting.lua     # 代码格式化（conform.nvim）
    │   ├── ide-enhancements.lua # IDE 功能（搜索替换、多光标、终端等）
    │   ├── languages.lua      # 语言支持导入
    │   ├── linting.lua        # 代码检查（nvim-lint）
    │   ├── lsp.lua            # LSP 配置（服务器、Lspsaga）
    │   ├── neo-tree.lua       # 文件浏览器配置
    │   ├── network-optimization.lua # Lazy.nvim 网络优化
    │   ├── testing.lua        # 测试配置（neotest）
    │   └── treesitter.lua     # Treesitter 配置
    └── rainbow_cursor.lua     # 彩虹光标效果
```

---

## 插件列表

### 核心框架

| 插件 | 说明 |
|------|------|
| [LazyVim](https://github.com/LazyVim/LazyVim) | Neovim 配置框架 |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理器 |

### 外观主题

| 插件 | 说明 |
|------|------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | TokyoNight 主题 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | 启动页 |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | 文件图标 |

### 编辑器增强

| 插件 | 说明 |
|------|------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 自动补全括号 |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | 自动关闭 HTML 标签 |
| [ts-comments.nvim](https://github.com/folke/ts-comments.nvim) | 注释增强 |
| [outline.nvim](https://github.com/hedyhli/outline.nvim) | 代码大纲 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 状态显示 |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO 高亮 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进线 |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | 高亮相同单词 |
| [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) | 搜索高亮增强 |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | 彩虹括号 |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | CSS 颜色预览 |

### 搜索与导航

| 插件 | 说明 |
|------|------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找 |
| [flash.nvim](https://github.com/folke/flash.nvim) | 快速跳转 |
| [project.nvim](https://github.com/ahmedkhalf/project.nvim) | 项目管理 |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | 搜索替换 |
| [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) | 全局搜索替换 |

### LSP 与代码

| 插件 | 说明 |
|------|------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) | LSP 增强界面 |
| [blink.cmp](https://github.com/saghen/blink.cmp) | 代码补全 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | 代码检查 |
| [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) | 增量重命名 |
| [dial.nvim](https://github.com/monaqa/dial.nvim) | 智能增减 |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | 诊断列表 |

### 调试与测试

| 插件 | 说明 |
|------|------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | 调试适配器 |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | 调试界面 |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python 调试 |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go 调试 |
| [neotest](https://github.com/nvim-neotest/neotest) | 测试框架 |

### 终端与工具

| 插件 | 说明 |
|------|------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 终端切换 |
| [LazyGit](https://github.com/kdheepak/lazygit.nvim) | Git TUI |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | 剪贴板历史 |
| [bookmarks.nvim](https://github.com/tomasky/bookmarks.nvim) | 书签管理 |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | 会话管理 |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown 预览 |

### 光标效果

| 插件 | 说明 |
|------|------|
| [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) | 光标拖尾动画 |
| rainbow_cursor.lua | 彩虹光标效果（自定义） |

### 其他

| 插件 | 说明 |
|------|------|
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | 代码折叠增强 |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | 多光标编辑 |
| [mini.map](https://github.com/nvim-mini/mini.map) | 迷你地图 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | 快捷键提示 |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | 平滑滚动 |
| [nvim-scrollview](https://github.com/dstein64/nvim-scrollview) | 滚动条 |
| [conoline.vim](https://github.com/miyakogi/conoline.vim) | 高亮当前行 |

---

## 许可证

[Apache-2.0](LICENSE)
