require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	highlight = {
		enable = true,
	},
	auto_install = false, -- prevent runtime parser install
})
