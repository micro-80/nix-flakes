local M = {}

local notes_dir = os.getenv("HOME") .. "/Notes"
local telescope = require('telescope.builtin')

M.create_work_note = function()
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

return M

