return {
  {
    "akinsho/bufferline.nvim",
    config = function()
      local setup_bufferline = function()
        local has_nord, nord = pcall(require, "nord")
        local using_nord = vim.g.colors_name == "nord"
        local highlights = {}

        if has_nord and using_nord and not vim.g.nord_disable_background then
          highlights = nord.bufferline.highlights({
            italic = true,
            bold = true,
          })
        end

        require("bufferline").setup({
          options = {
            mode = "buffers",
            separator_style = "thick",
            diagnostics = "nvim_lsp",
          },
          highlights = highlights,
        })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("BufferLineHighlights", { clear = true }),
        callback = setup_bufferline,
      })

      setup_bufferline()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
        globalstatus = true,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter"
    },
    config = true,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },
}
