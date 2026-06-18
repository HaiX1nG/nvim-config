-- IDE 增强功能配置
-- 让 Neovim 像 VSCode 一样好用
-- 基于 LazyVim 官方文档: https://www.lazyvim.org

return {
  -- ====================
  -- 搜索替换 (VSCode 风格)
  -- ====================
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {
      headerMaxWidth = 80,
      keymaps = {
        close = { "q", "<Esc>" },
        openNextLocation = "n",
        openPrevLocation = "N",
        gotoLocation = "<CR>",
        pickHistoryEntry = "<Up>",
        applyNext = "<C-Enter>",
      },
    },
    keys = {
      -- 搜索替换 (类似 VSCode 的 Ctrl+H)
      { "<D-h>", "<cmd>GrugFar<cr>", desc = "Search and Replace (⌘H)" },
      -- 在当前文件中搜索替换
      { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and Replace" },
      -- 在当前文件中搜索
      { "<leader>sw", "<cmd>GrugFar word<cr>", desc = "Search Current Word" },
    },
  },

  -- ====================
  -- 项目管理
  -- ====================
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "pattern", ".git" },
      patterns = { ".git", "Makefile", "package.json", "go.mod", "Cargo.toml" },
      show_hidden = true,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
      { "<D-S-p>", "<cmd>Telescope projects<cr>", desc = "Open Project (⌘⇧P)" },
    },
  },

  -- ====================
  -- 代码折叠增强
  -- ====================
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "VeryLazy",
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
      -- 设置折叠键
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = "eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸"
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With" },
      { "zp", function() local winid = require("ufo").peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end, desc = "Peek Fold" },
    },
  },

  -- ====================
  -- 会话管理 (自动保存/恢复会话)
  -- ====================
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("data") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
      pre_save = nil,
      save_empty = false,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop Session Save" },
      { "<leader>qS", function() require("persistence").save() end, desc = "Save Session" },
    },
  },

  -- ====================
  -- 多光标编辑 (VSCode 风格)
  -- ====================
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<D-d>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"] = "<D-S-d>",
        ["Skip Region"] = "<C-x>",
        ["Remove Region"] = "<C-p>",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }
    end,
  },

  -- ====================
  -- 快速跳转 (类似 VSCode 的 Ctrl+G)
  -- ====================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = true,
          multi_line = true,
        },
      },
      labels = "asdfghjklqwertyuiopzxcvbnm",
      label = {
        rainbow = {
          enabled = true,
        },
      },
    },
    keys = {
      -- 快速跳转（使用 gs 前缀避免覆盖 vim 原生 s/S）
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- 类似 VSCode 的 Ctrl+G 跳转到行
      { "<D-g>", mode = { "n", "x", "o" }, function() require("flash").jump({ pattern = vim.fn.line(".") .. ":" }) end, desc = "Go to Line (⌘G)" },
    },
  },

  -- ====================
  -- 通知增强 (已禁用，使用 LazyVim 内置的 snacks.nvim + noice.nvim)
  -- ====================
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  -- ====================
  -- 代码截图 (已禁用)
  -- ====================
  {
    "mistricky/codesnap.nvim",
    enabled = false,
    build = "make",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save Selected Code Snapshot into Clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save Selected Code Snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures/codesnap/",
      watermark = "",
      has_breadcrumbs = true,
      bg_theme = "hardhacker",
      breadcrumbs_separator = "/",
      has_line_number = true,
    },
  },

  -- ====================
  -- 迷你地图 (类似 VSCode 的 minimap, 纯 Lua 实现)
  -- ====================
  {
    "nvim-mini/mini.map",
    event = "VeryLazy",
    keys = {
      { "<leader>um", function() require("mini.map").toggle() end, desc = "Toggle Minimap" },
      { "<D-S-m>", function() require("mini.map").toggle() end, desc = "Toggle Minimap (⌘⇧M)" },
    },
    config = function()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot("4x2"),
        },
        window = {
          side = "right",
          width = 20,
          winblend = 15,
        },
      })
    end,
  },

  -- ====================
  -- 标签页管理
  -- ====================
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<D-t>", "<cmd>tabnew<cr>", desc = "New Tab (⌘T)" },
      { "<D-S-t>", "<cmd>BufferLineCloseRight<cr>", desc = "Close Others (⌘⇧T)" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
      { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
      { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to Buffer 3" },
      { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to Buffer 4" },
      { "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to Buffer 5" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
      { "<leader>bc", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to Right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to Left" },
    },
    opts = {
      options = {
        mode = "buffers",
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and "" or ""
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        separator_style = "thin",
        indicator = {
          style = "underline",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        enforce_regular_tabs = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
    },
  },

  -- ====================
  -- 终端增强
  -- ====================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<D-`>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
      highlights = {
        Normal = { link = "Normal" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
    },
    keys = {
      { "<D-`>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal (⌘`)" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
      { "<D-S-t>", "<cmd>TermExec cmd=''<cr>", desc = "New Terminal (⌘⇧T)" },
    },
  },

  -- ====================
  -- 面包屑导航 (VSCode 风格)
  -- ====================
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = {
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟿 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
    },
    config = function(_, opts)
      require("nvim-navic").setup(opts)
      -- 在状态栏显示面包屑
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },

  -- ====================
  -- 增量重命名预览
  -- ====================
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    opts = {
      hl_group = "IncSearch",
      preview_empty_name = true,
      show_message = true,
      input_buffer_type = nil,
    },
    config = function(_, opts)
      require("inc_rename").setup(opts)
    end,
  },

  -- ====================
  -- Dial.nvim (增强的增减操作)
  -- ====================
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local dial = require("dial.map")
      local augend = require("dial.augend")

      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.binary,
          augend.integer.alias.octal,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.semver.alias.semver,
          augend.case.new({
            types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
            cyclic = true,
          }),
        },
      })

      -- 键位映射（避免和 Ctrl+A/X 冲突）
      vim.keymap.set("n", "g<C-a>", dial.inc_normal(), { desc = "Increment" })
      vim.keymap.set("n", "g<C-x>", dial.dec_normal(), { desc = "Decrement" })
      vim.keymap.set("v", "g<C-a>", dial.inc_visual(), { desc = "Increment" })
      vim.keymap.set("v", "g<C-x>", dial.dec_visual(), { desc = "Decrement" })
    end,
  },

  -- ====================
  -- Mini.diff (更好的 diff 视图)
  -- ====================
  {
    "nvim-mini/mini.diff",
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
      },
      mappings = {
        apply = "gh",
        reset = "gH",
        textobject = "gh",
        goto_prev = "[H",
        goto_next = "]H",
      },
    },
    config = function(_, opts)
      require("mini.diff").setup(opts)
    end,
  },

  -- ====================
  -- Todo-Comments (TODO 高亮和列表)
  -- ====================
  -- 已在 editor.lua 中配置

  -- ====================
  -- Trouble (诊断列表)
  -- ====================
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        diagnostics = {
          auto_open = false,
          auto_close = true,
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- ====================
  -- Which-key (快捷键提示)
  -- ====================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 500,
      icons = {
        mappings = true,
        keys = {},
      },
      spec = {
        { "<leader>b", group = "buffer", icon = " " },
        { "<leader>c", group = "code", icon = " " },
        { "<leader>d", group = "debug", icon = " " },
        { "<leader>f", group = "find", icon = " " },
        { "<leader>g", group = "git", icon = " " },
        { "<leader>s", group = "search", icon = " " },
        { "<leader>t", group = "toggle/test", icon = " " },
        { "<leader>u", group = "ui", icon = " " },
        { "<leader>x", group = "diagnostics/quickfix", icon = " " },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
      },
    },
  },

  -- ====================
  -- Yanky (剪贴板历史)
  -- ====================
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
      },
      picker = {
        select = {
          action = nil,
        },
        telescope = {
          use_default_mappings = true,
          mappings = nil,
        },
      },
      system_clipboard = {
        sync_with_ring = true,
        clipboard_register = nil,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    },
    keys = {
      -- 不覆盖原生 p/P，用 leader 前缀
      { "<leader>p", "<cmd>YankyRingHistory<cr>", desc = "Yank History" },
      { "<leader>P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Before (Yanky)" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Previous Yank" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Next Yank" },
    },
  },

  -- ====================
  -- 自动保存书签
  -- ====================
  {
    "tomasky/bookmarks.nvim",
    event = "VeryLazy",
    opts = {
      sign_priority = 8,
      signs = {
        add = { hl = "BookMarksAdd", text = "", numhl = "" },
        ann = { hl = "BookMarksAnn", text = "", numhl = "" },
      },
      on_attach = function(bufnr)
        local bm = require("bookmarks")
        local map = vim.keymap.set
        map("n", "mm", bm.bookmark_toggle, { desc = "Toggle Bookmark", buffer = bufnr })
        map("n", "mi", bm.bookmark_ann, { desc = "Add Bookmark Annotation", buffer = bufnr })
        map("n", "mc", bm.bookmark_clean, { desc = "Clean Bookmarks in Buffer", buffer = bufnr })
        map("n", "mn", bm.bookmark_next, { desc = "Next Bookmark", buffer = bufnr })
        map("n", "mp", bm.bookmark_prev, { desc = "Previous Bookmark", buffer = bufnr })
        map("n", "ml", bm.bookmark_list, { desc = "List Bookmarks", buffer = bufnr })
      end,
    },
  },

  -- ====================
  -- Spectre (全局搜索替换)
  -- ====================
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    build = false,
    opts = {
      live_update = true,
      is_insert_mode = false,
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
    },
    keys = {
      { "<leader>sp", '<cmd>lua require("spectre").toggle()<cr>', desc = "Toggle Spectre" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', desc = "Search Current Word" },
      { "<leader>sp", '<esc><cmd>lua require("spectre").open_visual()<cr>', mode = "v", desc = "Search Selected" },
      { "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', desc = "Search in File" },
    },
  },

  -- ====================
  -- Telescope 增强
  -- ====================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        multi_icon = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!**/.git/*",
          "--glob=!**/node_modules/*",
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = "smart_send_to_qflist",
            ["<C-s>"] = "select_vertical",
            ["<C-h>"] = "select_horizontal",
            ["<C-t>"] = "select_tab",
          },
          n = {
            ["<C-s>"] = "select_vertical",
            ["<C-h>"] = "select_horizontal",
            ["<C-t>"] = "select_tab",
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".svn",
          ".hg",
          ".cache",
          "%.o",
          "%.a",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = {
            "fd",
            "--type=f",
            "--hidden",
            "--follow",
            "--exclude=.git",
            "--exclude=node_modules",
          },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          sort_lastused = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
            n = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      -- ui-select 需要在 telescope 加载后才能获取 themes
      opts.extensions = opts.extensions or {}
      opts.extensions["ui-select"] = require("telescope.themes").get_dropdown({})
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "live_grep_args")
      pcall(telescope.load_extension, "projects")
    end,
    keys = {
      { "<D-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files (⌘P)" },
      { "<D-S-p>", "<cmd>Telescope commands<cr>", desc = "Command Palette (⌘⇧P)" },
      { "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in File (⌘F)" },
      { "<D-g>", "<cmd>Telescope live_grep<cr>", desc = "Find in Project (⌘G)" },
      { "<D-b>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers (⌘B)" },
      { "<D-o>", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files (⌘O)" },
      { "<D-/>", "<cmd>Telescope live_grep<cr>", desc = "Search (⌘/)" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo List" },
    },
  },
}
