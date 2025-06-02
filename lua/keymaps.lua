local map = vim.keymap.set
local opts = { silent = true }

-- Telescope
map("n", "<leader><space>", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>rg", "<cmd>Telescope live_grep<cr>", opts)

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", opts)

-- Gitsigns
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", opts)

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", vim.diagnostic.setloclist, opts)
map("n", "<leader>dq", vim.diagnostic.setqflist, opts)
map("n", "<leader>dt", function()
  local config = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, opts)
map("n", "<leader>dc", function()
  local diagnostic = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })[1]
  if diagnostic then
    vim.fn.setreg("+", diagnostic.message)
    vim.notify("Copied diagnostic message to clipboard", vim.log.levels.INFO)
  end
end, opts)

-- ToggleTerm: floating lazygit
map("n", "<leader>lg", function()
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({ cmd = "lazygit", direction = "float", hidden = true }):toggle()
end, opts)

-- ToggleTerm: new floating terminal (blank)
map("n", "<leader>tt", function()
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({ direction = "float", hidden = true }):toggle()
end, opts)