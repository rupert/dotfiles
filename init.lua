require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
})

vim.lsp.config("eslint", {
  settings = {
    format = { enable = true },
    workingDirectory = { mode = "auto" },
    codeActionOnSave = { enable = true, mode = "problems" },
  },
})

vim.lsp.enable({ "tsgo", "eslint", "nixd" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = event.buf,
        command = "LspEslintFixAll",
      })
      return
    end

    if client.name == "tsgo" then
      return
    end

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})


vim.diagnostic.config({ virtual_text = true })

vim.cmd.colorscheme("tokyonight")

vim.g.mapleader = " "

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fh", telescope.help_tags)

vim.keymap.set("n", "gO", telescope.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "grr", telescope.lsp_references, { desc = "References" })
vim.keymap.set("n", "gri", telescope.lsp_implementations, { desc = "Implementations" })
vim.keymap.set("n", "grt", telescope.lsp_type_definitions, { desc = "Type definitions" })

vim.keymap.set("i", "<M-3>", "#", { silent = true })
