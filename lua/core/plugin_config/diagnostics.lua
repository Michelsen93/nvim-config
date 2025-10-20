local M = {}
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

function M.next()
    goto_diagnostic("next")
end

function M.prev()
    goto_diagnostic("prev")
end

function M.open_float()
    vim.diagnostic.open_float(nil, { border = "rounded", focus = false })
end

local function maybe_telescope_diagnostics(bufopts)
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        vim.keymap.set(
            "n",
            "<Space>da",
            telescope.diagnostics,
            vim.tbl_extend("force", bufopts, { desc = "Show all diagnostics (Telescope)" })
        )
    end
end

function M.setup(bufopts)
    bufopts = bufopts or { noremap = true, silent = true }

    vim.keymap.set(
        "n",
        "<Space>dn",
        M.next,
        vim.tbl_extend("force", bufopts, { desc = "Next diagnostic (by severity)" })
    )
    vim.keymap.set(
        "n",
        "<Space>dp",
        M.prev,
        vim.tbl_extend("force", bufopts, { desc = "Previous diagnostic (by severity)" })
    )
    vim.keymap.set(
        "n",
        "<Space>de",
        M.open_float,
        vim.tbl_extend("force", bufopts, { desc = "Show diagnostic under cursor" })
    )

    vim.keymap.set("n", "<Space>dv", function()
        local current = vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = not current })
    end, vim.tbl_extend("force", bufopts, { desc = "Toggle diagnostic virtual text" }))

    maybe_telescope_diagnostics(bufopts)
end

return M
