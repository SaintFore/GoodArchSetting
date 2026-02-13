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
-- imv
vim.keymap.set("n", "<leader>im", function()
  -- 1. 获取当前缓冲区的完整路径
  local current_file = vim.api.nvim_buf_get_name(0)
  -- 2. 获取光标下的字符串内容
  local cursor_file = vim.fn.expand("<cfile>")

  local target = ""

  -- 逻辑判断：
  -- 如果当前文件本身就是图片（以 png, jpg, webp 等结尾），直接开看
  if current_file:match("%.png$") or current_file:match("%.jpg$") or current_file:match("%.webp$") then
    target = current_file
  else
    -- 否则，我们认为你在代码里，尝试寻找光标下的路径
    -- 先尝试绝对路径，再尝试相对于项目根目录的路径
    local abs_path = vim.fn.fnamemodify(cursor_file, ":p")
    if vim.fn.filereadable(abs_path) == 1 then
      target = abs_path
    else
      target = vim.fn.getcwd() .. "/" .. cursor_file
    end
  end

  -- 最后检查 target 是否有效
  if target ~= "" and vim.fn.filereadable(target) == 1 then
    vim.notify("正在预览: " .. target, vim.log.levels.INFO)
    vim.fn.jobstart({ "imv", target }, { detach = true })
  else
    vim.notify("错误：找不到有效的图片路径。抓取到的内容为: " .. cursor_file, vim.log.levels.ERROR)
  end
end, { desc = "智能图片预览" })
