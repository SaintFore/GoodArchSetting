return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- vtsls = false, -- 禁用vtsls避免ts 5.9.3 bug，
        -- vtsls: -32603: Request textDocument/inlayHint failed with message: <semantic> TypeScript Server Error (5.9.3)
        -- astro的ts lsp与ts的lsp冲突了，应该是版本不同的问题
      },
    },
  },
}
