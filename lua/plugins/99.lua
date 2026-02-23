return {
  {
    "ThePrimeagen/99",
    event = "VeryLazy",
    config = function()
      local _99 = require("99")

      -- Get workspace name for logs
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)

      _99.setup({
        -- Use OpenCode provider (default)
        -- provider = _99.Providers.OpenCodeProvider,
        
        -- Debug logging
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        
        -- Temp directory for agent workspace
        tmp_dir = "./tmp",

        -- Completions for #rules and @files in prompt buffer
        completion = {
          -- Custom rules directories (optional)
          -- custom_rules = {
          --   "scratch/custom_rules/",
          -- },
          
          -- File completion settings
          files = {
            enabled = true,
            max_file_size = 102400,  -- 100KB
            max_files = 5000,
            -- exclude patterns added automatically
          },

          -- CMP integration
          source = "cmp",
        },

        -- Auto-load AGENT.md files from current directory
        md_files = {
          "AGENT.md",
        },
      })

      -- Visual selection editing (v mode only)
      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end, { desc = "99: Edit visual selection" })

      -- Search-based prompts
      vim.keymap.set("n", "<leader>9s", function()
        _99.search()
      end, { desc = "99: Search prompt" })

      -- Cancel all requests
      vim.keymap.set("n", "<leader>9x", function()
        _99.stop_all_requests()
      end, { desc = "99: Stop all requests" })
    end,
  },
}
