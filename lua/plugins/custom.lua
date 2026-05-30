-- 自定义配置和额外插件
-- 这里可以添加您自己的插件和配置

return {
  -- ====================
  -- 主题配置
  -- ====================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
    },
  },

  -- ====================
  -- 状态栏美化
  -- ====================
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },

  -- ====================
  -- 文件浏览器美化
  -- ====================
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
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
}
