local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "github_dark_high_contrast" } },
    -- import/override with your plugins
    { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    -- dap
    { import = "lazyvim.plugins.extras.dap.core" },
    -- editor
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.editor.aerial" },
    -- { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "lazyvim.plugins.extras.editor.overseer" },
    -- { import = "lazyvim.plugins.extras.coding.neogen" },
    -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    -- { import = "lazyvim.plugins.extras.editor.harpoon2" },
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    -- { import = "lazyvim.plugins.extras.editor.refactoring" },
    -- { import = "lazyvim.plugins.extras.editor.outline" },
    -- { import = "lazyvim.plugins.extras.editor.telescope" },
    -- formating
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- lang
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.helm" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    -- linter
    -- { import = "lazyvim.plugins.extras.linting.eslint" },
    -- lsp
    -- test
    -- ui
    -- { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
    -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
    { import = "lazyvim.plugins.extras.util.project" },
    -- util

    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
