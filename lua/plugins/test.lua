return {
  {
    "vim-test/vim-test",
    config = function()
      -- Define the custom strategy
      function TestStrategy(cmd)
        vim.cmd("enew")
        vim.cmd("terminal " .. cmd)
      end

      -- Set the custom strategy
      vim.g["test#custom_strategies"] = { tab_term = TestStrategy }
      vim.g["test#strategy"] = "tab_term"

      -- Normal Mocha command
      vim.g["test#javascript#mocha#executable"] = "npm run mocha:single:skipbuild "
      vim.g["test#typescript#mocha#executable"] = "npm run mocha:single:skipbuild "

      -- Debug function
      function DebugNearest()
        -- Set the test runner to 'inspectbrk'
        vim.g["test#javascript#mocha#executable"] = "npm run mocha:single:inspectbrk "
        vim.g["test#typescript#mocha#executable"] = "npm run mocha:single:inspectbrk "
        vim.cmd("TestNearest")
        -- Revert to the normal Mocha command
        vim.g["test#javascript#mocha#executable"] = "npm run mocha:single:skipbuild "
        vim.g["test#typescript#mocha#executable"] = "npm run mocha:single:skipbuild "
      end

      -- Create DebugNearest command
      vim.api.nvim_create_user_command("DebugNearest", function()
        DebugNearest()
      end, {})

      -- Keybindings for running tests
      vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>td", ":DebugNearest<CR>", { noremap = true, silent = true })
    end,
  },
}
