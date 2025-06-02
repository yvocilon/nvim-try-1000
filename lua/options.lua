vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt
o.number = true
o.relativenumber = true
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.termguicolors = true
o.signcolumn = "yes"
o.clipboard = "unnamedplus"

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true, -- Show inline diagnostics
  signs = true, -- Show signs in the sign column
  underline = true, -- Underline the text with the diagnostic
  update_in_insert = false, -- Don't update diagnostics while in insert mode
  severity_sort = true, -- Sort diagnostics by severity
  float = {
    border = "rounded", -- Add a border to floating windows
    source = "always", -- Always show the source of the diagnostic
    header = "", -- Remove the header
    prefix = "", -- Remove the prefix
  },
})