if false then
  return {}
end
return {
  { "nvim-lua/plenary.nvim" },
  { "neovim/nvim-lspconfig" },
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
      settings = {
        tsserver_max_memory = 12288,
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
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "npm run mocha:single",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
              "${port}",
            },
          },
        }
      end
      if not dap.adapters["node"] then
        dap.adapters["node"] = function(cb, config)
          if config.type == "node" then
            config.type = "pwa-node"
          end
          local nativeAdapter = dap.adapters["pwa-node"]
          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "npm run mocha:single:inspectbrk ${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
}
