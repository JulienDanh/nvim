return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false, -- Set to false to prevent diagnostics from updating in insert mode
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = true,
      },
      servers = {
        eslint = {
          enabled = true,
          handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
              update_in_insert = false, -- disable diagnostics while typing
              virtual_text = false, -- or enable but keep minimal
              debounce_text_changes = 500,
            }),
          },
          settings = {
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
            codeActionOnSave = {
              enable = false,
              mode = "all",
            },
            debug = true,
            format = false,
            -- nodePath = "",
            onIgnoredFiles = "off",
            -- packageManager = "npm",
            -- quiet = false,
            -- rulesCustomizations = {},
            run = "onSave",
            useESLintClass = false,
            validate = "on",
            workingDirectory = { mode = "auto" },
          },
          flags = {
            debounce_text_changes = 500, -- Adjust the debounce time (in milliseconds) as needed
          },
        },
      },
    },
  },
}
