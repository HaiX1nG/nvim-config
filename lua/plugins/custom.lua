-- 自定义配置和额外插件
-- 这里可以添加您自己的插件和配置

return {
  -- ====================
  -- 光标拖尾动画
  -- https://github.com/sphamba/smear-cursor.nvim
  -- ====================
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smear_cursor").setup({
        -- 尾部长度
        tail_length = 80,
        -- 动画速度（降低让拖尾更长）
        stiffness = 0.15,
        -- 拖尾衰减速度
        trailing_stiffness = 0.1,
        -- 预判/反冲效果
        anticipation = 0.5,
        -- 阻尼
        damping = 0.5,
        -- 拖尾指数
        trailing_exponent = 0.6,
        -- 隐藏真实光标
        hide_target_hack = true,
        -- 各方向拖尾
        vertical_smear = true,
        horizontal_smear = true,
        diagonal_smear = true,
        -- 动画帧间隔
        time_interval = 5,
      })
    end,
  },

  -- ====================
  -- 光标高亮（当前行/列）
  -- https://github.com/tummetott/flash.nvim
  -- ====================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- ====================
  -- 主题配置: Kanagawa
  -- https://github.com/rebelot/kanagawa.nvim
  -- ====================
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- ====================
  -- 状态栏美化 (lualine.nvim)
  -- https://github.com/nvim-lualine/lualine.nvim
  -- ====================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local sysinfo = require("utils.sysinfo")

      -- 自定义主题配色 (kanagawa wave 主题 - 柔和协调)
      local colors = {
        bg       = "#1F1F28",      -- sumiInk3 (背景)
        fg       = "#DCD7BA",      -- fujiWhite (主文字)
        yellow   = "#E6C384",      -- carpYellow (柔和黄)
        cyan     = "#7FB4CA",      -- springBlue (天蓝)
        green    = "#98BB6C",      -- springGreen (嫩绿)
        orange   = "#FFA066",      -- surimiOrange (柔和橙)
        magenta  = "#D27E99",      -- sakuraPink (樱花粉)
        blue     = "#7E9CD8",      -- crystalBlue (水晶蓝)
        red      = "#E46876",      -- waveRed (柔和红)
        darkblue = "#2D4F67",      -- waveBlue2 (深蓝背景)
        violet   = "#957FB8",      -- oniViolet (紫)
      }

      -- 自定义模式显示
      local mode_map = {
        ["n"]      = "NORMAL",
        ["no"]     = "O-PENDING",
        ["nov"]    = "O-PENDING",
        ["noV"]    = "O-PENDING",
        ["no\22"]  = "O-PENDING",
        ["niI"]    = "NORMAL",
        ["niR"]    = "NORMAL",
        ["niV"]    = "NORMAL",
        ["nt"]     = "NORMAL",
        ["ntT"]    = "NORMAL",
        ["v"]      = "VISUAL",
        ["vs"]     = "VISUAL",
        ["V"]      = "V-LINE",
        ["Vs"]     = "V-LINE",
        ["\22"]    = "V-BLOCK",
        ["\22s"]   = "V-BLOCK",
        ["s"]      = "SELECT",
        ["S"]      = "S-LINE",
        ["\19"]    = "S-BLOCK",
        ["i"]      = "INSERT",
        ["ic"]     = "INSERT",
        ["ix"]     = "INSERT",
        ["R"]      = "REPLACE",
        ["Rc"]     = "REPLACE",
        ["Rx"]     = "REPLACE",
        ["Rv"]     = "V-REPLACE",
        ["Rvc"]    = "V-REPLACE",
        ["Rvx"]    = "V-REPLACE",
        ["c"]      = "COMMAND",
        ["cv"]     = "EX",
        ["ce"]     = "EX",
        ["r"]      = "REPLACE",
        ["rm"]     = "MORE",
        ["r?"]     = "CONFIRM",
        ["!"]      = "SHELL",
        ["t"]      = "TERMINAL",
      }

      -- 模式对应颜色
      local mode_color = {
        n = colors.green,
        i = colors.blue,
        v = colors.magenta,
        ["\22"] = colors.magenta,
        V = colors.magenta,
        c = colors.orange,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        ["\19"] = colors.orange,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red,
      }

      -- 自定义文件名组件（带图标和修改标记）
      local function custom_filename()
        local filename = vim.fn.expand("%:t")
        if filename == "" then
          return "[No Name]"
        end
        local extension = vim.fn.expand("%:e")
        local icon = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
        local modified = vim.bo.modified and " ●" or ""
        return icon .. " " .. filename .. modified
      end

      -- 自定义文件大小
      local function file_size()
        local size = vim.fn.getfsize(vim.fn.expand("%:p"))
        if size < 0 then
          return ""
        end
        local units = { "B", "KB", "MB", "GB" }
        local unit_idx = 1
        while size > 1024 and unit_idx < #units do
          size = size / 1024
          unit_idx = unit_idx + 1
        end
        return string.format("%.1f %s", size, units[unit_idx])
      end

      -- 自定义 LSP 状态
      local function lsp_status()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return " " .. table.concat(names, ", ")
      end

      -- 自定义诊断图标
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = " ",
          warn  = " ",
          info  = " ",
          hint  = " ",
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }

      -- 自定义 diff 图标
      local diff = {
        "diff",
        symbols = {
          added     = " ",
          modified  = " ",
          removed   = " ",
        },
        colored = true,
      }

      -- 自定义分支
      local branch = {
        "branch",
        icon = " ",
        color = { fg = colors.violet, gui = "bold" },
      }

      -- 自定义位置（行:列）
      local location = {
        "location",
        padding = { left = 0, right = 1 },
      }

      -- 自定义进度
      local progress = {
        "progress",
        fmt = function(str)
          -- lualine 的 progress 组件返回 "65%" 格式，直接返回即可
          return str
        end,
        color = { fg = colors.fg, gui = "bold" },
      }

      -- 自定义文件编码
      local encoding = {
        "encoding",
        fmt = function(str)
          return str:upper()
        end,
        color = { fg = colors.cyan },
      }

      -- 自定义文件格式
      local fileformat = {
        "fileformat",
        symbols = {
          unix = " ",
          dos  = " ",
          mac  = " ",
        },
        color = { fg = colors.yellow },
      }

      -- 自定义文件类型
      local filetype = {
        "filetype",
        icon_only = false,
        colored = true,
        color = { fg = colors.fg },
      }

      -- CPU/MEM 监控组件（带颜色）
      local sys_monitor = {
        function()
          return sysinfo.system_info()
        end,
        color = function()
          local handle = io.popen("ps -o %cpu=,rss= -p " .. vim.fn.getpid())
          if handle then
            local result = handle:read("*a")
            handle:close()
            local cpu_str, mem_kb = result:match("([%d%.]+)%s+([%d]+)")
            if cpu_str and mem_kb then
              local cpu = tonumber(cpu_str)
              local mem = math.floor(tonumber(mem_kb) / 1024)
              if cpu > 80 or mem > 500 then
                return { fg = colors.red, gui = "bold" }
              elseif cpu > 50 or mem > 200 then
                return { fg = colors.yellow }
              else
                return { fg = colors.green }
              end
            end
          end
          return { fg = colors.green }
        end,
        icon = " ",
      }

      -- 动态模式组件
      local mode_component = {
        function()
          local mode = vim.fn.mode()
          return " " .. (mode_map[mode] or mode)
        end,
        color = function()
          local mode = vim.fn.mode()
          return { fg = mode_color[mode] or colors.green, bg = colors.darkblue, gui = "bold" }
        end,
        padding = { left = 1, right = 1 },
      }

      -- 确保状态栏显示（LazyVim 启动页会隐藏它）
      vim.o.laststatus = 3

      -- 修复 alpha/dashboard 关闭后状态栏消失的问题
      vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        pattern = "*",
        callback = function()
          if vim.o.laststatus == 0 then
            vim.o.laststatus = 3
          end
        end,
      })

      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = { mode_component },
          lualine_b = {
            branch,
            diff,
            diagnostics,
          },
          lualine_c = {
            custom_filename,
            { lsp_status, color = { fg = colors.cyan } },
          },
          lualine_x = {
            file_size,
            encoding,
            fileformat,
            filetype,
          },
          lualine_y = {
            progress,
          },
          lualine_z = {
            location,
            sys_monitor,
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1, color = { fg = colors.fg } } },
          lualine_x = { { "location", color = { fg = colors.fg } } },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      })
    end,
  },

  -- ====================
  -- 禁用 Yazi，使用 Neo-tree 作为文件浏览器
  -- ====================
  {
    "mikavilpas/yazi.nvim",
    enabled = false,
  },

  -- ====================
  -- Telescope 文件浏览器（可选，保留快捷键但改用 Neo-tree）
  -- ====================
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- ====================
  -- 代码大纲
  -- ====================
  {
    "hedyhli/outline.nvim",
    keys = {
      { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
    opts = {},
  },

  -- ====================
  -- 彩虹括号
  -- ====================
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  -- ====================
  -- 滚动条
  -- ====================
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts = {},
  },

  -- ====================
  -- 平滑滚动
  -- ====================
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ====================
  -- 高亮当前行
  -- ====================
  {
    "miyakogi/conoline.vim",
    event = "VeryLazy",
    init = function()
      vim.g.conoline_auto_enable = 1
    end,
  },

  -- ====================
  -- 颜色预览
  -- ====================
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    ft = { "css", "scss", "sass", "less", "html", "javascript", "typescript", "vue" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ====================
  -- 括号高亮
  -- ====================
  {
    "luochen1990/rainbow",
    event = "VeryLazy",
    init = function()
      vim.g.rainbow_active = 1
    end,
  },

  -- ====================
  -- 更好的搜索高亮
  -- ====================
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup()
    end,
  },

  -- ====================
  -- 更好的缩进线
  -- ====================
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = true },
    },
  },

  -- ====================
  -- 文件图标增强 (icons.nvim)
  -- https://github.com/nvim-tree/nvim-web-devicons
  -- ====================
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },

  -- ====================
  -- LSP Completion 图标 (lspkind.nvim)
  -- https://github.com/onsails/lspkind.nvim
  -- ====================
  {
    "onsails/lspkind.nvim",
    lazy = true,
    opts = {
      mode = "symbol_text",
      preset = "default",
      symbol_map = {
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

  -- ====================
  -- 启动页美化
  -- ====================
  {
    "goolord/alpha-nvim",
    optional = true,
    opts = function(_, opts)
      local dashboard = require("alpha.themes.dashboard")
      opts.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ═╝  ═══╝══════╝ ═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }
      return opts
    end,
  },

  -- ====================
  -- Markdown 预览 (浏览器)
  -- https://github.com/iamcco/markdown-preview.nvim
  -- ====================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "md" },
    build = "cd app && npm install",
    config = function()
      -- 设置浏览器（使用系统默认浏览器）
      vim.g.mkdp_browser = ""
      -- 自动打开预览
      vim.g.mkdp_auto_start = 0
      -- 关闭文件时自动关闭预览
      vim.g.mkdp_auto_close = 1
      -- 刷新延迟（毫秒）
      vim.g.mkdp_refresh_slow = 0
      -- 预览窗口是否获得焦点
      vim.g.mkdp_preview_options = {
        -- 禁用同步滚动
        sync_scroll_type = "middle",
        -- 禁用目录
        disable_sync_scroll = 0,
        -- 禁用目录
        disable_filename = 0,
      }
      -- 主题
      vim.g.mkdp_theme = "dark"
      -- 文件类型
      vim.g.mkdp_filetypes = { "markdown", "md" }
    end,
  },
}
