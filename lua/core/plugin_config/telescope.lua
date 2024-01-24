require('telescope').setup()
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>ff', builtin.live_grep, {})
