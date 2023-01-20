local M = {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  cmd = "Mason",
}

function M.config()
  require("mason.settings").set({
    ui = {
      border = "rounded",
    }
  })
  local navic = require("nvim-navic")
  navic.setup({
    highlight = true,
  })

  local lsp = require("lsp-zero")
  lsp.preset("recommended")
  lsp.ensure_installed({
    "sumneko_lua",
    "pyright",
    "rust_analyzer",
    "clangd",
    "marksman",
    "html",
    "tsserver",
  })

  -- lsp.set_preferences({
  --   sign_icons = {
  --     error = "",
  --     warn = "",
  --     hint = "",
  --     info = ""
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

    local lsp_cmd = fmt("<cmd>lua vim.lsp.buf.%s<cr>")
    map("n", "K", lsp_cmd("hover()"))
    map("n", "gd", lsp_cmd("definition()"))
    map("n", "gD", lsp_cmd("declaration()"))
    map("n", "gi", lsp_cmd("implementation()"))
    map("n", "go", lsp_cmd("type_definition()"))
    map("n", "gr", lsp_cmd("references()"))
    map("n", "<F2>", lsp_cmd("rename()"))
    map("n", "<F4>", lsp_cmd("code_action()"))
    map("x", "<F4>", lsp_cmd("range_code_action()"))
    map("n", "<C-k>", lsp_cmd("buf.signature_help()"))
    map("n", "<leader>f", lsp_cmd("format()"))

    if pcall(require, "telescope.builtin") then
      local telescope_lsp = fmt("<cmd>lua require(\"telescope.builtin\").lsp_%s<cr>")
      map("n", "gd", telescope_lsp("definitions()"))
      map("n", "gi", telescope_lsp("implementations()"))
      map("n", "go", telescope_lsp("type_definitions()"))
      map("n", "gr", telescope_lsp("references()"))
    end

    local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<cr>")
    map("n", "gl", diagnostic("open_float()"))
    map("n", "[d", diagnostic("goto_prev()"))
    map("n", "]d", diagnostic("goto_next()"))

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end)

  lsp.configure("sumneko_lua", {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  lsp.setup()
  vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end

return M
