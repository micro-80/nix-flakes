local opts = {
	clipboard = "unnamedplus",
	incsearch = true,
	number = true,
	showcmd = true,
	termguicolors = true,

	signcolumn = "yes",
	wildmenu = true,

	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,
}

-- Apply the options globally
for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	virtual_text = true, -- show error messages inline (next to the text)
	signs = true, -- show signs in the gutter (you already have this)
	underline = true, -- underline problematic text
	update_in_insert = false,
	severity_sort = true,
})
