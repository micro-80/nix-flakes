-- Set global leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<M-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<M-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<M-w>", ":bd<CR>", { silent = true, desc = "Close buffer" })

-- Plugins
local opts = { silent = true, noremap = true }

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
