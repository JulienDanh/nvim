return {
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      -- Normal Mocha command
      vim.g["test#javascript#mocha#executable"] = "npm run mocha:single "
      vim.g["test#typescript#mocha#executable"] = "npm run mocha:single "

      vim.g["test#custom_strategies"] = {
        mocha_debug = function(cmd)
          return "npm run mocha:single:inspectbrk"
        end,
      }
      function DebugNearest()
        -- Set the test runner to 'delve'

        vim.g["test#javascript#mocha#executable"] = "npm run mocha:single:inspectbrk "
        vim.g["test#typescript#mocha#executable"] = "npm run mocha:single:inspectbrk "
        vim.cmd("TestNearest")

        vim.g["test#javascript#mocha#executable"] = "npm run mocha:single "
        vim.g["test#typescript#mocha#executable"] = "npm run mocha:single "
      end
      vim.api.nvim_create_user_command("DebugNearest", function()
        DebugNearest()
      end, {})

      -- Keybindings for running tests
      vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>td", ":DebugNearest<CR>", { noremap = true, silent = true })
    end,
  },
}
