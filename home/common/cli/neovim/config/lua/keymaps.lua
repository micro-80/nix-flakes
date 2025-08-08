-- Set global leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set keymaps (example for normal mode)
vim.keymap.set("n", "<A-w>", ":bd<CR>", { silent = true })
