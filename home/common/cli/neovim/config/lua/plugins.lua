require("gitsigns").setup()
require("mini.comment").setup()
require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("render-markdown").setup({})

require("catppuccin").setup({
	flavour = "macchiato",
})
vim.cmd.colorscheme("catppuccin")

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<A-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<A-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "buffer" },
	}),
})

require("nvim-autopairs").setup({})

require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	highlight = {
		enable = true,
	},
	auto_install = false, -- prevent runtime parser install
})

require("oil").setup({
	default_file_explorer = true,
	buf_options = {
		buflisted = false,
		bufhidden = "hide",
	},
})

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<A-j>"] = actions.move_selection_next,
				["<A-k>"] = actions.move_selection_previous,
			},
		},
	},
})
