return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    cmp.setup({
      enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
        if in_prompt then
          return false
        end
        local context = require('cmp.config.context')
        return not(context.in_treesitter_capture('comment') == true or context.in_syntax_group('Comment'))
      end,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,preview,select',
      },
      mapping = cmp.mapping.preset.insert({
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-c>'] = cmp.mapping.abort(),
        ['<tab>'] = cmp.mapping.confirm(),
        ['<c-j>'] = cmp.mapping.select_next_item(),
        ['<c-k>'] = cmp.mapping.select_prev_item(),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.config.disable,
        ['<c-y>'] = cmp.config.disable,
        ['<c-n>'] = cmp.config.disable,
        ['<c-p>'] = cmp.config.disable,
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        {
          name = 'nvim_lsp',
          -- entry_filter = function(entry, ctx)
          --   return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
          -- end
        },
        { name = 'path' },
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
