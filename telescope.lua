return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          'node_modules',
          '*.jpeg',
          '*.jpg',
          '*.png'
        },
        prompt_prefix = '  ',
        selection_caret = '  ',
        path_display = { 'truncate' },
        layout_config = {
          preview_width = 0.55,
          -- horizontal = {
          --   preview_cutoff = 0
          -- }
        },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<c-j>'] = actions.move_selection_next,
            ['<c-k>'] = actions.move_selection_previous,
            ['<c-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<c-f>'] = actions.preview_scrolling_down,
            ['<c-b>'] = actions.preview_scrolling_up,
            ['<c-[>'] = actions.close,
          },
        },
      },
    })

    telescope.load_extension('fzf')

    vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fc', builtin.grep_string, {})
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end,
}
