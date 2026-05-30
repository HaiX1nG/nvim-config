-- 诊断浮窗自动显示
-- 光标停留时自动显示错误信息

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_diagnostics_float", { clear = true }),
  callback = function(event)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focus = false,
          scope = "cursor",
          border = "rounded",
          source = "always",
          -- 显示行号、列号和错误信息
          format = function(diagnostic)
            return string.format("%s (行 %d, 列 %d)", diagnostic.message, diagnostic.lnum + 1, diagnostic.col)
          end,
        })
      end,
    })
  end,
})

-- 快捷键查看所有诊断
vim.keymap.set("n", "<leader>xd", function()
  vim.diagnostic.open_float(nil, { focus = true, scope = "line" })
end, { desc = "Show Line Diagnostics" })

-- 诊断导航快捷键
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostic Quickfix" })
