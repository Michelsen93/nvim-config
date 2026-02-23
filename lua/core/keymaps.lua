vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Toggle GitHub Copilot completions
vim.keymap.set('n', '<leader>gc', function()
  if vim.g.copilot_enabled then
    require("copilot.command").disable()
    vim.g.copilot_enabled = false
    vim.notify("Copilot OFF", vim.log.levels.INFO)
  else
    require("copilot.command").enable()
    vim.g.copilot_enabled = true
    vim.notify("Copilot ON", vim.log.levels.INFO)
  end
end, { desc = "Toggle GitHub Copilot" })

