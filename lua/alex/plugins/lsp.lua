return {
    {
        "neovim/nvim-lspconfig",

        config = function()
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("gopls", {
                capabilities = capabilities,
            })

            vim.lsp.enable("gopls")

            -- FORMATAR AO SALVAR
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = { "source.organizeImports" },
                        },
                        apply = true,
                    })

                    vim.lsp.buf.format()
                end,
            })

            -- CTRL + S = FORMATAR + SALVAR
            vim.keymap.set("n", "<C-s>", function()
                vim.lsp.buf.format()
                vim.cmd("w")
            end, { desc = "Format and save" })
        end,
    },
}