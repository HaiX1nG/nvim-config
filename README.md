# Neovim + LazyVim 配置

## 支持的语言

- **Java** (jdtls)
- **Go** (gopls)
- **Rust** (rust-analyzer)
- **C/C++** (clangd)
- **Objective-C** (clangd)
- **C#** (omnisharp)
- **HTML/CSS** (html-lsp, css-lsp)
- **JavaScript/TypeScript** (vtsls)
- **React** (vtsls)
- **Vue** (vue-language-server)
- **PHP** (intelephense)
- **Lua** (lua-language-server)
- **Python** (pyright, ruff)

## 特性

- 代码补全 (blink.cmp)
- 语法高亮 (Treesitter)
- LSP 支持
- 代码格式化 (conform.nvim)
- 代码检查 (nvim-lint)
- 调试支持 (nvim-dap)
- 测试支持 (neotest)
- Git 集成
- 文件浏览器
- 模糊查找
- 主题美化

## 快捷键

- `<Space>` - Leader 键
- `<D-s>` - 保存文件
- `<D-o>` - 打开文件
- `<D-f>` - 查找文件
- `<D-g>` - 全局搜索
- `<D-d>` - 跳转到定义
- `<D-u>` - 查找引用
- `<D-i>` - 格式化文档
- `<D-k>` - 显示文档
- `<D-1>` - 文件树

## 安装

1. 确保已安装依赖:
   - Neovim >= 0.9.0
   - Git
   - Node.js
   - Python3
   - Go
   - Java
   - Rust

2. 运行 Neovim:
   ```bash
   nvim
   ```

3. LazyVim 会自动安装所有插件

4. 安装 LSP 服务器:
   ```
   :Mason
   ```

## 配置结构

```
~/.config/nvim/
├── init.lua                    # 入口文件
├── lazyvim.json               # LazyVim 配置
├── stylua.toml                # Lua 格式化配置
└── lua/
    ├── config/
    │   ├── autocmds.lua       # 自动命令
    │   ├── diagnostics.lua    # 诊断配置
    │   ├── keymaps.lua        # 键位映射
    │   └── options.lua        # 选项配置
    └── plugins/
        ├── cmp.lua            # 代码补全
        ├── custom.lua         # 自定义插件
        ├── dap.lua            # 调试配置
        ├── editor.lua         # 编辑器增强
        ├── formatting.lua     # 格式化配置
        ├── languages.lua      # 语言支持
        ├── linting.lua        # 代码检查
        ├── lsp.lua            # LSP 配置
        ├── mason.lua          # Mason 工具
        ├── network-optimization.lua # 网络优化
        ├── testing.lua        # 测试配置
        └── treesitter.lua     # Treesitter 配置
```
