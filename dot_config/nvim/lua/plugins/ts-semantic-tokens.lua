return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          capabilities = (function()
            local caps = vim.lsp.protocol.make_client_capabilities()

            -- Advertise semantic tokens support
            caps.textDocument = caps.textDocument or {}
            caps.textDocument.semanticTokens =
                vim.lsp.protocol.make_client_capabilities().textDocument.semanticTokens

            return caps
          end)(),
        },
      },
    },
  },
}
