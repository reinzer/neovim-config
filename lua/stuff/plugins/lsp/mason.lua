return {
    "mason-org/mason.nvim",
    lazy = false,
    enabled = true,
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
    },
    config = function()
        -- import mason and mason_lspconfig
        local mason = require("mason").setup({
            registries = {
                "github:Crashdummyy/mason-registry",
                "github:mason-org/mason-registry",
            }
        })
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        --[[mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })]]

        mason_lspconfig.setup({
            automatic_enable = false,
            -- servers for mason to install
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "gopls",
                "angularls",
                "astro",
                "emmet_ls",
                "emmet_language_server",
                "marksman",
                --"csharp_ls",
                "pylsp",
                "jdtls",
                "bashls",
                --"ast_grep",
                "harper_ls",
                "asm_lsp",
                "neocmake",
                "jsonls",
                "snyk_ls",
                --"glslls",
                "glsl_analyzer",
                "rust_analyzer",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "biome",
                "prettier",
                "stylua",
                "isort",
                "pylint",
                "clangd",
                "denols",
                "shellcheck",
                "cpplint",
                "beautysh",
                "htmlhint",
                "eslint_d",
                "codelldb",
                "gdtoolkit",
            },
        })
    end,
}
