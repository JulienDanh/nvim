return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 1000,
          },
          settings = {
            run = "onSave",
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
