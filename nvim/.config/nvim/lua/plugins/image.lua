return {
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/luarocks.nvim" }, -- 自动处理 lua 依赖
    opts = {
      backend = "sixel",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true, -- 建议开启，防止预览太多图导致卡顿
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
    },
  },
}
