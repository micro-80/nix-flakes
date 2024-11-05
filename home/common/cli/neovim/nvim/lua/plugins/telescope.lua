return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		tag = "0.1.8",
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
			vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
		end,
	},
}
