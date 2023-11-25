return {
  {
    'theprimeagen/harpoon',
    config = function ()
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')

      vim.keymap.set('n', '<leader>a', mark.add_file)
      vim.keymap.set('n', '<leader>e', ui.toggle_quick_menu)
      vim.keymap.set('n', '<a-h>', function() ui.nav_file(1) end)
      vim.keymap.set('n', '<a-j>', function() ui.nav_file(2) end)
      vim.keymap.set('n', '<a-k>', function() ui.nav_file(3) end)
      vim.keymap.set('n', '<a-l>', function() ui.nav_file(4) end)
      vim.keymap.set('n', '<a-;>', function() ui.nav_file(5) end)
    end
  }
}
