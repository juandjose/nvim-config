vim.g.mapleader = ' '

vim.keymap.set('n', '<c-z>', '<nop>')

vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 's', '"_s')

vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('c', '<c-b>', '<Left.')
vim.keymap.set('c', '<c-f>', '<Right>')
vim.keymap.set('c', '<c-a>', '<Home>')
vim.keymap.set('c', '<c-e>', '<End>')
vim.keymap.set('c', '<a-b>', '<s-left>')
vim.keymap.set('c', '<a-f>', '<s-right>')
