return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup()
			-- require('mini.pairs').setup()

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.notify").setup()
			require("mini.surround").setup()
			require("mini.statusline").setup({ use_icons = true })
		end,
	},
}
