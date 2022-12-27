local lsp = require('lsp-zero')
local navic = require("nvim-navic")
navic.setup({
  highlight = true,
})

lsp.preset('recommended')
lsp.ensure_installed({
  'sumneko_lua',
  'pyright',
  'rust_analyzer',
})

-- lsp.set_preferences({
--   sign_icons = {
--     error = '',
--     warn = '',
--     hint = '',
--     info = ''
--   }
-- })

lsp.nvim_workspace()

-- stolen straight from the plugin
-- slight tweaks + navic (code context)
lsp.on_attach(function(client, bufnr)
  local fmt = function(cmd) return function(str) return cmd:format(str) end end

  local map = function(m, lhs, rhs)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, opts)
  end

  local lsp_cmd = fmt('<cmd>lua vim.lsp.buf.%s<cr>')
  map('n', 'K', lsp_cmd 'hover()')
  map('n', 'gd', lsp_cmd 'definition()')
  map('n', 'gD', lsp_cmd 'declaration()')
  map('n', 'gi', lsp_cmd 'implementation()')
  map('n', 'go', lsp_cmd 'type_definition()')
  map('n', 'gr', lsp_cmd 'references()')
  map('n', '<F2>', lsp_cmd 'rename()')
  map('n', '<F4>', lsp_cmd 'code_action()')
  map('x', '<F4>', lsp_cmd 'range_code_action()')
  map('n', '<leader>f', lsp_cmd 'format()')

  local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')
  map('n', 'gl', diagnostic 'open_float()')
  map('n', '[d', diagnostic 'goto_prev()')
  map('n', ']d', diagnostic 'goto_next()')

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end)

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  }
})

lsp.setup()
vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
