local servers = {
	bashls = {},
	clangd = {},
	svelte = {},
	ts_ls = {},
	rust_analyzer = {},
}

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- LSP buffer keymaps
	local buf_keymap = {
		["gd"] = "definition",
		["gD"] = "references",
		["gt"] = "type_definition",
		["gi"] = "implementation",
		["K"] = "hover",
		["<leader>A"] = "code_action",
	}
	for key, func in pairs(buf_keymap) do
		vim.keymap.set("n", key, function()
			vim.lsp.buf[func]()
		end, opts)
	end

	-- Diagnostic keymaps
	local diag_keymap = {
		["<leader>k"] = vim.diagnostic.goto_prev,
		["<leader>j"] = vim.diagnostic.goto_next,
	}
	for key, func in pairs(diag_keymap) do
		vim.keymap.set("n", key, func, opts)
	end
end

-- Setup servers
for server, config in pairs(servers) do
	lspconfig[server].setup(vim.tbl_extend("force", {
		on_attach = on_attach,
	}, config))
end
