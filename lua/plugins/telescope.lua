return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fm",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.loop.cwd(),
          find_command = { "sh", "-c", "git diff --name-only --diff-filter=d" },
        })
      end,
      desc = "Find Git Modified Files",
    },
  },
}
