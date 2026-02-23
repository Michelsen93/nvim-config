-- Diagnostics utilities
local diagnostics = {}

local function goto_diagnostic(direction)
  local opts = { float = { border = "rounded" } }
  local severities = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
  }

  for _, severity in ipairs(severities) do
    local diags = vim.diagnostic.get(0, { severity = severity })
    if diags and #diags > 0 then
      opts.severity = severity
      if direction == "next" then
        vim.diagnostic.goto_next(opts)
      else
        vim.diagnostic.goto_prev(opts)
      end
      return
    end
  end
  vim.notify("No diagnostics found!", vim.log.levels.INFO)
end

diagnostics.next = function() goto_diagnostic("next") end
diagnostics.prev = function() goto_diagnostic("prev") end
diagnostics.open_float = function()
  vim.diagnostic.open_float(nil, { border = "rounded", focus = false })
end

local function setup_diagnostics_keymaps(bufopts)
  bufopts = bufopts or { noremap = true, silent = true }
  vim.keymap.set("n", "<Space>dn", diagnostics.next, vim.tbl_extend("force", bufopts, { desc = "Next diagnostic" }))
  vim.keymap.set("n", "<Space>dp", diagnostics.prev, vim.tbl_extend("force", bufopts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "<Space>de", diagnostics.open_float, vim.tbl_extend("force", bufopts, { desc = "Show diagnostic" }))
  vim.keymap.set("n", "<Space>dv", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
  end, vim.tbl_extend("force", bufopts, { desc = "Toggle diagnostic virtual text" }))

  local ok, telescope = pcall(require, "telescope.builtin")
  if ok then
    vim.keymap.set("n", "<Space>da", telescope.diagnostics, vim.tbl_extend("force", bufopts, { desc = "Show all diagnostics" }))
  end
end

-- LSP on_attach callback
local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  setup_diagnostics_keymaps(bufopts)

  vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Space>pr", function() vim.lsp.buf.format({ async = true }) end, bufopts)
  vim.keymap.set("n", "<Space>gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<Space>gi", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "<Space>gr", require("telescope.builtin").lsp_references, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<Space>gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
end

return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local lsp_servers = {
        "lua_ls",
        "terraformls",
        "gopls",
        "jsonls",
        "cssls",
        "rust_analyzer",
        "zls",
        "ts_ls",
        "omnisharp",
        "templ",
        "dockerls",
        "html",
        "htmx",
        "bashls",
        "yamlls",
        "bicep",
      }
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
      })
    end,
  },
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Filetype mappings
      vim.filetype.add({
        extension = {
          templ = "templ",
          tf = "terraform",
          tfvars = "terraform",
        }
      })

      -- Helm templates autocmd
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*/templates/*.yaml", "*/templates/*.tpl" },
        callback = function()
          vim.bo.filetype = "helm"
        end,
      })

      -- Go-specific keymap
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.keymap.set("n", "<Space>ie", function()
            local line = "if err != nil {"
            local ret_line = "\treturn"
            local end_brace = "}"
            local row = vim.api.nvim_win_get_cursor(0)[1]
            vim.api.nvim_buf_set_lines(0, row, row, false, { line, ret_line, end_brace })
          end, { buffer = true, desc = "Insert if err != nil { return }" })
        end,
      })

      -- LSP setup (Neovim 0.11+ API)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('yamlls', {
        filetypes = { "yaml", "helm" },
      })

      vim.lsp.config('helm_ls', {
        filetypes = { "helm" },
        cmd = { "helm_ls", "serve" },
        settings = {
          ['helm-ls'] = {
            yamlls = { enabled = true }
          }
        },
      })

      local lsp_servers = {
        "lua_ls", "terraformls", "gopls", "jsonls", "cssls",
        "rust_analyzer", "zls", "ts_ls", "omnisharp", "templ",
        "dockerls", "html", "htmx", "bashls", "yamlls", "bicep",
      }
      local all_servers = vim.list_extend({}, lsp_servers)
      table.insert(all_servers, "helm_ls")
      vim.lsp.enable(all_servers)

      -- Global LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and bufnr then
            on_attach(client, bufnr)
          end
        end,
      })
    end,
  },
  -- LSP progress UI
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {},
  },
}
