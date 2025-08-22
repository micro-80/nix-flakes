-- Autocmd for buffer-local Markdown settings only
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_gb"
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end
})

