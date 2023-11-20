return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    -- { 'antosha417/nvim-lsp-file-operations',config = true },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local on_attach = function(client, bufnr)
      local opts = {buffer = bufnr, remap = false}

      vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set('n', 'gI', function () vim.lsp.buf.implementation() end, opts)
      vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
      vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = {
      Error = ' ',
      Warn = ' ',
      -- Hint = '󰠠 ',
      Hint = '',
      Info = ' '
    }

    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['tsserver'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['tailwindcss'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['svelte'].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { '*.js', '*.ts' },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end
        })
      end
    })

    lspconfig['prismals'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['graphql'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        'graphql',
        'gql',
        'svelte',
        'typescriptreact',
        'javascriptreact'
      },
    })

    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
        'svelte'
      },
      init_options = {
        html = {
          options = {
            ['bem.enabled'] = true
          }
        }
      }
    })

    lspconfig['pyright'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['clangd'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })
  end,
}
