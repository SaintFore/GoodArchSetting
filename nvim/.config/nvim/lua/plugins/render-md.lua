return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  opts = {
    heading = {
      enabled = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
    },

    checkbox = {
      enabled = true,
      unchecked = {
        icon = "☐ ",
      },
      checked = {
        icon = "✔ ",
      },
    },

    code = {
      sign = false,
      width = "block",
      border = "thin",
    },
  },
}
