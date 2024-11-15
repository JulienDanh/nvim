return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    },
    config = function()
      -- Setup typescript-tools
      require("typescript-tools").setup({
        -- Optional settings for typescript-tools
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }

          local set_keymap = vim.keymap.set
          -- LSP key mappings
          set_keymap("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
          set_keymap("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
          set_keymap("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
          set_keymap("n", "gr", vim.lsp.buf.references, opts) -- Find references
          set_keymap("n", "K", vim.lsp.buf.hover, opts) -- Hover docs
          set_keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
          set_keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code action
          set_keymap("n", "<leader>fm", function()
            vim.lsp.buf.format({ async = true })
          end, opts) -- Format file
          set_keymap("n", "<leader>ds", vim.lsp.buf.document_symbol, opts) -- Document symbols
          set_keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts) -- Workspace symbols
          set_keymap("n", "<leader>e", vim.diagnostic.open_float, opts) -- Show diagnostics
          set_keymap("n", "[d", vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
          set_keymap("n", "]d", vim.diagnostic.goto_next, opts) -- Go to next diagnostic

          -- Typescript-tools specific mappings
          set_keymap("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<CR>", opts) -- Organize imports
          set_keymap("n", "<leader>ru", "<cmd>TSToolsRemoveUnused<CR>", opts) -- Remove unused imports/vars
          set_keymap("n", "<leader>fa", "<cmd>TSToolsFixAll<CR>", opts) -- Fix all auto-fixable issues
          set_keymap("n", "<leader>gI", "<cmd>TSToolsGoToSourceDefinition<CR>", opts) -- Go to source definition
        end,
        settings = {
          tsserver_max_memory = 12288,
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "relative",
          },
        },
      })
    end,
  },
}
