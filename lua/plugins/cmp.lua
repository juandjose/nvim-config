return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- 'rafamadriz/friendly-snippets',

    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    -- require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      enabled = function ()
        local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
        if in_prompt then
          return false
        end
        local context = require("cmp.config.context")
        return not(context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
      end,
      completion = {
        completeopt = 'menu,menuone,preview,select',
      },
      mapping = cmp.mapping.preset.insert({
        ['<c-k>'] = cmp.mapping.select_prev_item(),
        ['<c-j>'] = cmp.mapping.select_next_item(),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<tab>'] = cmp.mapping.confirm(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        -- { name = 'luasnip' },
      }),

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = '...',
        }),
      },
    })
  end,
}
