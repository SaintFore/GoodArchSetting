-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { desc = "离开" })
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, {
  desc = "当前文件的错误",
})
vim.keymap.set("n", "<leader>xX", vim.diagnostic.setqflist, {
  desc = "整个项目的错误",
})
