-- Set global leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set keymaps (example for normal mode)
vim.keymap.set("n", "<A-w>", ":bd<CR>", { silent = true })

vim.keymap.set("n", "<M-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<M-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
