return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Davidyz/VectorCode",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          model = "gemini-2.5-pro",
        },
        inline = {
          adapter = "copilot",
          model = "gemini-2.5-pro",
        },
        cmd = {
          adapter = "copilot",
          model = "gemini-2.5-pro",
        },
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
      -- Set debug logging
      log_level = "DEBUG",

      extensions = {},
    },
    keys = {
      {
        "<leader>at",
        "<cmd>CodeCompanionChat<CR>",
        desc = "Open CodeCompanion Palette",
      },
      {
        "<leader>aa",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open CodeCompanion Actions",
      },
    },
  },
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
