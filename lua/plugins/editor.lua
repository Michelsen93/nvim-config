return {
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = {
      { "<c-n>", ":NvimTreeFindFileToggle<CR>", desc = "Toggle nvim-tree" },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = {
          width = 40,
        }
      })
    end,
  },
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<Space>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
      { "<Space><Space>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<Space>ff", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
    config = function()
      require('telescope').setup()
    end,
  },
  -- Harpoon
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<Space>m", function() require("harpoon.mark").add_file() end, desc = "Harpoon mark file" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
      { "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon file 1" },
      { "<C-t>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon file 2" },
      { "<C-b>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon file 3" },
      { "<C-s>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon file 4" },
    },
  },
}
