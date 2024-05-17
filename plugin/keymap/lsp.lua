require('which-key').register {
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
  ['<leader>lt'] = { name = '[L]SP [T]rouble', _ = 'which_key_ignore' },
  ['<leader>lg'] = { name = '[L]SP [G]oto', _ = 'which_key_ignore' },
}

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')

nmap('<leader>le', vim.diagnostic.open_float, 'Open floating diagnostic message')
nmap('<leader>lq', vim.diagnostic.setloclist, 'Open diagnostics list')

nmap("<leader>lf", vim.lsp.buf.format, "format the code with LSP")

local toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
nmap('<leader>lih', toggle_inlay_hints, 'Toggle Inlay Hints')
