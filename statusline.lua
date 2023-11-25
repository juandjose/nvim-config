local function filename()
  local fname = vim.fn.expand '%:t'
  return (fname == '') and '[No Name]' or fname
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
    info,
  }
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    '%#Statusline#  ',
    filename(),
    ' %m',
    '%=%#StatusLineExtra#',
    lsp(),
    '  %l:%c  %P '
  }
end

function Statusline.inactive()
  return ' %f '
end

vim.api.nvim_exec([[
  augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
