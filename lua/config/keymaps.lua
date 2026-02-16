-- Keymaps configuration
-- Leader is set to space in config/lazy.lua

local map = vim.keymap.set

-- General
map("n", "<leader>pv", ":Oil<CR>", { desc = "Open file explorer", silent = true })
map("n", "-", ":Oil<CR>", { desc = "Open parent directory", silent = true })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize up", silent = true })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize down", silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize left", silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize right", silent = true })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up", silent = true })

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer", silent = true })

-- Save file
map("n", "<leader>w", ":w<CR>", { desc = "Save file", silent = true })

-- Quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit", silent = true })
