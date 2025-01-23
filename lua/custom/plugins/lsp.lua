return { {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "j-hui/fidget.nvim", opts = {} },
    "nvim-tree/nvim-web-devicons",
    'saghen/blink.cmp',
  },
  config = function()
    local lc = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    for _, lang in pairs { "lua_ls", "rust_analyzer", "nushell", "clangd" } do
      lc[lang].setup { capabilities = capabilities }
    end

    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references)

    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)

    vim.keymap.set("n", '<leader>le', vim.diagnostic.open_float)
    vim.keymap.set("n", '<leader>lq', vim.diagnostic.setloclist)

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

    vim.keymap.set("n", '<leader>li', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

    local rust_analyzer_activate_features = function(opts)
      require("lspconfig").rust_analyzer.setup {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              features = vim.split(opts.args, " +", { trimempty = true }),
            },
          }
        }
      }
    end

    local rust_analyzer_show_features = function()
      local clients = require("lspconfig").rust_analyzer.manager._clients
      for _, client in pairs(clients) do
        local features = vim.tbl_get(
          client,
          "rust_analyzer",
          "config",
          "settings",
          "rust-analyzer",
          "cargo",
          "features"
        ) or {}

        for _, v in pairs(features) do
          print(v)
        end
      end
      return 0
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        -- format on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end

        if client.name == "rust_analyzer" then
          vim.api.nvim_buf_create_user_command(
            0,
            'RustAnalyzerFeaturesActivate',
            rust_analyzer_activate_features,
            { nargs = '?' }
          )
          vim.api.nvim_buf_create_user_command(
            0,
            'RustAnalyzerFeaturesShow',
            rust_analyzer_show_features,
            {}
          )
        end
      end
    })
  end,
} }
