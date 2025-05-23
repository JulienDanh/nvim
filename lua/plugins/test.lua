return {
  {
    "vim-test/vim-test",
    config = function()
      local search_regression_cmd = "npm run mocha:search-regression:single"
      vim.g["test#strategy"] = "neovim_sticky"

      -- Normal Mocha command
      vim.g["test#javascript#mocha#executable"] = search_regression_cmd
      vim.g["test#typescript#mocha#executable"] = search_regression_cmd
      -- Debug function
      function DebugNearest()
        -- Set the test runner to 'inspectbrk'
        vim.g["test#javascript#mocha#executable"] = search_regression_cmd .. ":inspectbrk "
        vim.g["test#typescript#mocha#executable"] = search_regression_cmd .. ":inspectbrk "
        vim.cmd("TestNearest")
        -- Revert to the normal Mocha command
        vim.g["test#javascript#mocha#executable"] = search_regression_cmd
        vim.g["test#typescript#mocha#executable"] = search_regression_cmd
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
