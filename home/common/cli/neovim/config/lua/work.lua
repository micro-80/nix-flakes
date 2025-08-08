local M = {}

local notes_dir = os.getenv("HOME") .. "/Notes"
local telescope = require("telescope.builtin")

function M.create_work_note()
	local date = os.date("%Y-%m-%d")
	local filename = notes_dir .. "/" .. date .. ".md"

	vim.fn.mkdir(notes_dir, "p")

	local file_exists = vim.fn.filereadable(filename) == 1
	vim.cmd("edit " .. filename)

	if not file_exists then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { "# " .. date, "" })
	end
end

function M.find_notes_files()
	telescope.find_files({ cwd = notes_dir })
end

function M.grep_notes_files()
	telescope.live_grep({ cwd = notes_dir })
end

-- Set keymaps here, so when you require this module it auto-sets the mappings
function M.setup_keymaps()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>wn", M.create_work_note, opts)
	vim.keymap.set("n", "<leader>fwn", M.find_notes_files, opts)
	vim.keymap.set("n", "<leader>gwn", M.grep_notes_files, opts)
end

-- Automatically set keymaps when module is loaded (optional)
M.setup_keymaps()

return M
