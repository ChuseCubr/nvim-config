local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local null_ls = require("null-ls")

  local on_attach = function(client, bufnr)
    local fmt = function(cmd) return function(str) return cmd:format(str) end end

    local map = function(m, lhs, rhs)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, opts)
    end

    local lsp_cmd = fmt('<cmd>lua vim.lsp.buf.%s<cr>')
    map('n', 'K', lsp_cmd 'hover()')
    map('n', '<F4>', lsp_cmd 'code_action()')
    map('x', '<F4>', lsp_cmd 'range_code_action()')
    map('n', '<leader>f', lsp_cmd 'format()')

    local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')
    map('n', 'gl', diagnostic 'open_float()')
    map('n', '[d', diagnostic 'goto_prev()')
    map('n', ']d', diagnostic 'goto_next()')
  end

  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.autopep8,
    },
    on_attach = on_attach,
  })
end

return M
