return {
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" }, -- 可以在这些文件里预览
        },
        neorg = {
          enabled = true,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 90,
      max_height_window_percentage = 90,
      window_overlap_clear_enabled = false, -- 如果发现图片闪烁可以设为 true
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- 失去焦点时是否保留图片
      tmux_passthrough = true, -- 用 Tmux，必须开启透传
    },
  },
}
