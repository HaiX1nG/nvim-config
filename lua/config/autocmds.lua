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

-- 自动保存（离开插入模式或切换缓冲区时）
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function(args)
    -- 只在有修改且文件存在时保存
    if vim.bo[args.buf].modified and vim.bo[args.buf].buftype == "" then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd("silent! write")
      end)
    end
  end,
})

-- 自动保存前格式化
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    -- 使用 LSP 格式化
    vim.lsp.buf.format({ async = false, bufnr = args.buf })
  end,
})
