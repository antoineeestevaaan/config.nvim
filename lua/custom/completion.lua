local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'
local vscode = require('luasnip.loaders.from_vscode')

lspkind.init {}
vscode.lazy_load()
luasnip.config.setup {}

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = "buffer" },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noselect'
  },
  formatting = {
    format = lspkind.cmp_format {},
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
