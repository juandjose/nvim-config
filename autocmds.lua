vim.api.nvim_create_autocmd('TextYankPost', {
  command = 'silent! lua vim.highlight.on_yank()',
  group = vim.api.nvim_create_augroup(
    'YankHighlight',
    { clear = true }
  )
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
  callback = function ()
    local cmd = vim.v.event.cmdtype
    if cmd == '/' or cmd == '?' or 'g' then
      vim.opt.hlsearch = true
    end
  end
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
  callback = function ()
    local cmd = vim.v.event.cmdtype
    if cmd == '/' or cmd == '?' or 'g' then
      vim.opt.hlsearch = false
    end
  end
})

vim.api.nvim_create_user_command('CopyAbsolutePath', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('"' .. path .. '" Copied to the Clipboard!')
end, {})

vim.api.nvim_create_user_command('CopyFileName', function()
  local path = vim.fn.expand('%:t')
  vim.fn.setreg('+', path)
  vim.notify('"' .. path .. '" Copied to the Clipboard!')
end, {})

vim.cmd[[
  autocmd FileType * set fo-=cro
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufRead,BufNewFile *.html,*.css,*.js,*.ts,*.json,*.lua setl ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.js,*.ts,*.c,*.cpp,*.java setl cc=80
  " autocmd BufRead,BufNewFile *.html setlocal wrap
  let loaded_matchparen = 1
  colorscheme habamax
  hi Statusline guibg=#1c1c1c guifg=#9e9e9e
  hi StatuslineNC guibg=#1c1c1c guifg=#9e9e9e
  hi VertSplit guibg=#1c1c1c
]]
