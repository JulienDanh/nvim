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
            onIgnoredFiles = "off",
            run = "onSave",
            useESLintClass = false,
            validate = "on",
            workingDirectory = { mode = "auto" },
          },
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 2000, -- Adjust the debounce time (in milliseconds) as needed
          },
        },
      },
    },
  },
}
