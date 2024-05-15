return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        local telescope = require('telescope.builtin')
        nmap('<leader>lgd', telescope.lsp_definitions, '[G]oto [D]efinition')
        nmap('<leader>lgr', telescope.lsp_references, '[G]oto [R]eferences')
        nmap('<leader>lgI', telescope.lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>lD', telescope.lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>lds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>lws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('<leader>lh', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>ls', vim.lsp.buf.signature_help, 'Signature Documentation')

        nmap('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>lwf', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace list [F]olders')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      local lspconfig = require('lspconfig')
      lspconfig.nushell.setup {}

      vim.filetype.add({
        extension = {
          nuon = "nu",
        }
      })

      local servers = {
        clangd = {},
        rust_analyzer = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("trouble").setup {
        icons = true,
      }

      vim.keymap.set("n", "<leader>lto", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true, desc = "Open diagnostics" }
      )
      vim.keymap.set("n", "<leader>ltw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Open workspace diagnostics" }
      )
      vim.keymap.set("n", "<leader>ltd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Open document diagnostics" }
      )
      vim.keymap.set("n", "<leader>ltl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true, desc = "Open loclist" }
      )
      vim.keymap.set("n", "<leader>ltq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true, desc = "Open quickfix list" }
      )
      vim.keymap.set("n", "<leader>ltr", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true, desc = "Open references" }
      )
    end
  },

  {
    'rmagatti/goto-preview',
    config = function()
      local goto_preview = require('goto-preview')
      goto_preview.setup {}

      vim.keymap.set("n", "<leader>lgd", function() goto_preview.goto_preview_definition() end,
        { silent = true, desc = "Goto definition" })
      vim.keymap.set("n", "<leader>lgt", function() goto_preview.goto_preview_type_definition() end,
        { silent = true, desc = "Goto type" })
      vim.keymap.set("n", "<leader>lgi", function() goto_preview.goto_preview_implementation() end,
        { silent = true, desc = "Goto implementation" })
      vim.keymap.set("n", "<leader>lgc", function() goto_preview.close_all_win() end, { silent = true, desc = "Close all windows" })
      vim.keymap.set("n", "<leader>lgr", function() goto_preview.goto_preview_references() end,
        { silent = true, desc = "Goto references" })
    end
  },
}
