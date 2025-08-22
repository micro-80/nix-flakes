local opts = { silent = true, noremap = true }

-- Set global leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<M-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<M-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<M-w>", ":bd<CR>", { silent = true, desc = "Close buffer" })

vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz", { silent = true, desc = "Previous quickfix entry" })
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz", { silent = true, desc = "Next quickfix entry" })
vim.keymap.set("n", "<M-q>", "<cmd>cclose<CR>zz", { silent = true, desc = "Close quickfix entry" })

vim.keymap.set("n", "<Tab>", "za", opts)
vim.keymap.set("v", "<Tab>", "zf", opts)
vim.keymap.set("n", "<S-Tab>", "zR", opts)

vim.keymap.set("n", "<leader>zm", function()
    vim.cmd("ZenMode")
end, { desc = "Enter Zen Mode for Markdown" })

-- Plugins
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "z=", "<cmd>Telescope spell_suggest<cr>", opts)

