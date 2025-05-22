local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("oxfist/night-owl.nvim")
    use("nvim-tree/nvim-web-devicons")
    use({ "rose-pine/neovim", as = "rose-pine" })
    use 'navarasu/onedark.nvim'
    use("nvim-lualine/lualine.nvim")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    })
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    use({
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            require("fidget").setup({
                -- options
            })
        end,
    })
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    })
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })
    use({
        "akinsho/flutter-tools.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
    })
    use("theprimeagen/harpoon")
    use("lewis6991/gitsigns.nvim")
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    if packer_bootstrap then
        require("packer").sync()
    end
end)
