local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL LINE',
  [''] = 'VISUAL BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT LINE',
  [''] = 'SELECT BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode])
end

local function filename()
  local fname = vim.fn.expand '%:t'
  return (fname == '') and '' or fname
end

local function lsp()
  local count = {}
  local levels = {
    errors = 'Error',
    warnings = 'Warn',
    info = 'Info',
    hints = 'Hint',
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ''
  local warnings = ''
  local hints = ''
  local info = ''

  if count['errors'] ~= 0 then
    errors = ' %#LspDiagnosticsSignError# ' .. count['errors']
  end
  if count['warnings'] ~= 0 then
    warnings = ' %#LspDiagnosticsSignWarning# ' .. count['warnings']
  end
  if count['hints'] ~= 0 then
    hints = ' %#LspDiagnosticsSignHint#󰠠 ' .. count['hints']
  end
  if count['info'] ~= 0 then
    info = ' %#LspDiagnosticsSignInformation# ' .. count['info']
  end

  return table.concat {
    errors,
    warnings,
    hints,
    info
  }
end

Statusline = {}

Statusline.active = function()
  local lsptext = lsp()
  return table.concat {
    '%#Statusline#',
    mode(),
    '| ',
    filename(),
    ' %m',
    '%=%#StatusLineExtra#',
    (lsptext == '') and '' or lsptext .. ' |',
    ' %l:%c | %P '
  }
end

function Statusline.inactive()
  return ' %f '
end

function Statusline.short()
  return '%#StatusLineNC#   Netrw'
end

vim.api.nvim_exec([[
  augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    au WinEnter,BufEnter,FileType netrw setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
