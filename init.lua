local eslint_on_attach = vim.lsp.config.eslint.on_attach

vim.lsp.config("eslint", {
  settings = {
    format = { enable = true },
    workingDirectory = { mode = "auto" },
    codeActionOnSave = { enable = true, mode = "problems" },
  },
  on_attach = function(client, buffer)
    if not eslint_on_attach then return end

    eslint_on_attach(client, buffer)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      command = "LspEslintFixAll",
    })
  end,
})

vim.lsp.enable({ "vtsls", "eslint" })

vim.diagnostic.config({ virtual_text = true })
