-- 代码测试配置
-- 为各语言提供测试支持

return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      -- 测试适配器
      "nvim-neotest/neotest-python", -- Python
      "fredrikaverpil/neotest-golang", -- Go
      "rouge8/neotest-rust", -- Rust
      "alfaix/neotest-gtest", -- C/C++
    },
    opts = {
      adapters = {
        -- Python
        ["neotest-python"] = {
          runner = "pytest",
        },
        -- Go
        ["neotest-golang"] = {
          dap_go_enabled = true,
        },
        -- Rust
        ["neotest-rust"] = {
          dap = true,
        },
        -- C/C++
        ["neotest-gtest"] = {
          -- 自动检测 Google Test
        },
      },
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
}
