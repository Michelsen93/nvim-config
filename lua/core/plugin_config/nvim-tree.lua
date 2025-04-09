vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        width = 40,
        side = "right",
    }
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
