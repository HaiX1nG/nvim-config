-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- 文件类型自动识别
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.m" },
  callback = function()
    vim.bo.filetype = "objc"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.mm" },
  callback = function()
    vim.bo.filetype = "objcpp"
  end,
})

-- 自动保存（只在离开插入模式时保存，避免格式化干扰实时诊断）
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].modified and vim.bo[args.buf].buftype == "" then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd("silent! write")
      end)
    end
  end,
})

-- 保存前格式化（可选，按需启用）
-- 注意：这可能会干扰实时诊断，建议使用手动格式化 (⌘I)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     vim.lsp.buf.format({ async = false, bufnr = args.buf })
--   end,
-- })
