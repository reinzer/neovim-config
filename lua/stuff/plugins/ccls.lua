return{
    "ranjithshegde/ccls.nvim",
    lazy = false,
    config = function()
        require("ccls").setup({
            lsp = {
                server = {
                    cmd = { "/bin/ccls" },
                    root_markers = { "compile_commands.json", ".git" },
                    -- any other vim.lsp.config-compatible keys
                },
            },
        })
    end
}
