-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
-- Window navigation
vim.keymap.set("n", "sh", "<C-w>h", opts)
vim.keymap.set("n", "sj", "<C-w>j", opts)
vim.keymap.set("n", "sk", "<C-w>k", opts)
vim.keymap.set("n", "sl", "<C-w>l", opts)

-- Split windows
vim.keymap.set("n", "sv", ":vsplit<CR>", opts) -- Vertical split
vim.keymap.set("n", "ss", ":split<CR>", opts) -- Horizontal split

vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
