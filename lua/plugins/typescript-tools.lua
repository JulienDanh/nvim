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
          set_keymap("n", "<leader>gi", "<cmd>TSToolsAddMissingImports<CR>")
        end,
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = false,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = "insert_leave",
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          -- specify commands exposed as code_actions
          expose_as_code_action = { "add_missing_imports", "remove_unused", "remove_unused_imports" },
          -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
          -- not exists then standard path resolution strategy is applied
          tsserver_path = nil,
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {},
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = "auto",
          -- described below
          tsserver_format_options = {},
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "relative",
          },
          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = "en",
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          -- by default code lenses are displayed on all referencable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          -- JSXCloseTag
          -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
          -- that maybe have a conflict if enable this feature. )
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },
}
