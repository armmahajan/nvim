-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

-- Bootstrap lazy.nvim and load plugins
require("config.lazy")

-- Load keymaps
require("config.keymaps")

-- Floating terminal
require("config.terminal")
