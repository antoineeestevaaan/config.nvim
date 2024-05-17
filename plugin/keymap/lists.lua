local nmap = function(keys, func, desc)
  if desc then
    desc = 'LIST: ' .. desc
  end

  vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

-- quickfix window
nmap("<leader>co", "<cmd>copen<CR>", "open quick list")
nmap("<leader>cc", "<cmd>cclose<CR>", "close quick list")
nmap("<leader>cj", "<cmd>copen<CR><cmd>cnext<CR>zz", "next in quick list")
nmap("<leader>ck", "<cmd>copen<CR><cmd>cprev<CR>zz", "previous in quick list")

-- loc list
nmap("<leader>lo", "<cmd>lopen<CR>", "open loc list")
nmap("<leader>lc", "<cmd>lclose<CR>", "close loc list")
nmap("<leader>lj", "<cmd>lopen<CR><cmd>lnext<CR>zz", "next in loc list")
nmap("<leader>lk", "<cmd>lopen<CR><cmd>lprev<CR>zz", "previous in loc list")
