local opts = { silent = true, noremap = true }

vim.api.nvim_set_keymap("n", "<A-m-j>", ":BufferLineMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-m-k>", ":BufferLineMovePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-p>", ":BufferLineTogglePin<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-0>", ":BufferLineGoToBuffer -1<CR>", opts)

require("bufferline").setup({})
