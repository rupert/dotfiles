vim.g.mapleader = " "

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
})

require("gitsigns").setup({
  current_line_blame = true
})

require("neotest").setup({
  adapters = {
    require("neotest-vitest")
  }
})

require('telescope').load_extension('frecency')

vim.lsp.config("eslint", {
  settings = {
    format = { enable = true },
    workingDirectory = { mode = "auto" },
    codeActionOnSave = { enable = true, mode = "problems" },
  },
})

vim.lsp.enable({ "tsgo", "eslint", "nixd", "typos_lsp", "oxfmt" })

local lsp_group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf })

    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_group,
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
        group = lsp_group,
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my.treesitter', { clear = true }),
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})

vim.diagnostic.config({ virtual_text = true })

vim.cmd.colorscheme("tokyonight")

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fh", telescope.help_tags)

vim.keymap.set("n", "gO", telescope.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "grr", telescope.lsp_references, { desc = "References" })
vim.keymap.set("n", "gri", telescope.lsp_implementations, { desc = "Implementations" })
vim.keymap.set("n", "grt", telescope.lsp_type_definitions, { desc = "Type definitions" })

local neotest = require("neotest")
vim.keymap.set("n", "<leader>ta", function() neotest.run.attach() end, { desc = "Attach to Test" })
vim.keymap.set("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Show Output" })
vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle Output Panel" })
vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "Run Nearest" })
vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
vim.keymap.set("n", "<leader>tS", function() neotest.run.stop() end, { desc = "Stop" })
vim.keymap.set("n", "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
vim.keymap.set("n", "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, { desc = "Run All Test Files" })
vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle Watch" })
