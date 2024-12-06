local nmap = require("custom._utils").nmap

require('which-key').add {
    { "<leader>l", group = "[L]SP" },
    { "<leader>l_", hidden = true },
}

nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')

nmap('<leader>le', vim.diagnostic.open_float, 'Open floating diagnostic message')
nmap('<leader>lq', vim.diagnostic.setloclist, 'Open diagnostics list')

nmap("<leader>lf", vim.lsp.buf.format, "format the code with LSP")

local toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
nmap('<leader>li', toggle_inlay_hints, 'Toggle Inlay Hints')
