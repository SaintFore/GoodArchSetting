return {
  dir = "~/Code/lua-nvim/rest-time/",
  lazy = false,
  config = function()
    require("rest_time").setup({})
  end,
}
