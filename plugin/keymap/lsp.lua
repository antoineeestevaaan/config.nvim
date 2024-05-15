require('which-key').register {
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
  ['<leader>lt'] = { name = '[L]SP [T]rouble', _ = 'which_key_ignore' },
  ['<leader>lg'] = { name = '[L]SP [G]oto', _ = 'which_key_ignore' },
}

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format the code with LSP" })
