-- LSP 配置增强
-- 为不同语言提供更好的 LSP 支持

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 诊断配置 - 实时显示错误
      diagnostics = {
        underline = true,
        update_in_insert = true,  -- 插入模式下也更新诊断
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- 显示错误信息
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        float = {
          border = "rounded",
          source = "always",
          -- 显示行号和错误信息
          format = function(diagnostic)
            return string.format("%s (行 %d, 列 %d)", diagnostic.message, diagnostic.lnum + 1, diagnostic.col)
          end,
        },
      },
      -- 全局启用 inlay hints
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      -- LSP 服务器配置
      servers = {
        -- Lua LSP (Neovim 开发)
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
                checkThirdParty = false,
              },
              telemetry = { enable = false },
              hint = {
                enable = true,
                setType = true,
                arrayType = "Enable",
                paramName = "All",
                semicolon = "Disable",
              },
            },
          },
        },

        -- HTML/CSS
        html = {},
        cssls = {},

        -- Python (使用 pyright + ruff)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },

        -- Go
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
            },
          },
        },

        -- Rust (使用 rustaceanvim 管理)
        -- rust_analyzer = {
        --   enabled = false,
        -- },

        -- C/C++/Objective-C
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--inlay-hints",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },

        -- TypeScript/JavaScript (使用 vtsls)
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
              },
            },
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
              },
            },
          },
        },

        -- Vue
        vue_ls = {
          settings = {
            vue = {
              inlayHints = {
                inlineHandlerLeading = true,
                missingProps = true,
                optionsWrapper = false,
              },
            },
          },
        },

        -- Tailwind CSS
        tailwindcss = {},

        -- PHP
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = { "vendor" },
              },
              diagnostics = {
                enable = true,
              },
              format = {
                enable = true,
              },
            },
          },
        },

        -- C# (.NET)
        omnisharp = {
          settings = {
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              InlayHintsOptions = {
                EnableForParameters = true,
                ForLiteralParameters = true,
                ForObjectCreationParameters = true,
                ForIndexerParameters = true,
                ForOtherParameters = true,
                EnableForTypes = true,
                ForImplicitVariableTypes = true,
                ForImplicitObjectCreation = true,
                ForLambdaParameterTypes = true,
              },
            },
          },
        },

        -- CMake
        cmake = {},
      },
    },
  },

  -- 光标停留时自动显示诊断浮窗
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.rename = opts.rename or {}
      return opts
    end,
  },

  -- 代码操作增强 - 友好的 code action 界面
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({
        -- code action 弹窗配置
        codeaction = {
          show_server_name = true,
          extend_gitsigns = false,
        },
        -- 预览窗口
        preview = {
          lines_above = 0,
          lines_below = 10,
        },
        -- 滚动文档
        scroll_preview = {
          scroll_down = "<C-j>",
          scroll_up = "<C-k>",
        },
        -- 请求 lightbulb
        request_timeout = 2000,
        -- 浮动窗口样式
        ui = {
          border = "rounded",
          winblend = 0,
        },
        -- 悬停文档增强
        hover = {
          max_width = 0.6,
          max_height = 0.8,
          open_link = "gx",
          border = "rounded",
        },
        -- 诊断增强
        diagnostic = {
          border_follow = true,
          show_source = true,
          max_width = 0.6,
          max_height = 0.6,
        },
        -- 符号大纲
        symbol_in_winbar = {
          enable = true,
          separator = " > ",
          hide_mode = 0,
          show_file = true,
          folder_level = 2,
        },
      })
    end,
  },
}
