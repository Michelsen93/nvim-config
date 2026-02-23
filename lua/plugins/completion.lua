return {
  -- GitHub Copilot (no inline ghost text – completions only via cmp)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- disable inline ghost text
        panel = { enabled = false },      -- disable the side panel
      })
      -- Start with Copilot disabled; toggle with <leader>gc
      vim.defer_fn(function()
        require("copilot.command").disable()
        vim.g.copilot_enabled = false
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp = require("cmp")
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-o>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'copilot',  group_index = 1 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip',  group_index = 2 },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    lazy = true,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}
