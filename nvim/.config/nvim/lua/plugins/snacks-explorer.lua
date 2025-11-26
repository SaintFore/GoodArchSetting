-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- 默认将显示隐藏打开
          ignored = true, -- 默认将显示 gitignore 文件打开
        },
      },
    },
  },
}
