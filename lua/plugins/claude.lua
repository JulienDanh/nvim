return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    opts = {
      window = {
        split_ratio = 0.4,
        position = "vertical", -- Can be "left", "right", "top", or "bottom"
      },
    },
  },
}
