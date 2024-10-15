-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Window navigation
vim.keymap.set("n", "sh", "<C-w>h", { silent = true })
vim.keymap.set("n", "sj", "<C-w>j", { silent = true })
vim.keymap.set("n", "sk", "<C-w>k", { silent = true })
vim.keymap.set("n", "sl", "<C-w>l", { silent = true })

-- Split windows
vim.keymap.set("n", "sv", ":vsplit<CR>", { silent = true }) -- Vertical split
vim.keymap.set("n", "ss", ":split<CR>", { silent = true }) -- Horizontal split
