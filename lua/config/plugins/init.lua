return {
  -- file browser
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
  },

  -- code context
  {
    "SmiteshP/nvim-navic",
    dependencies =  "neovim/nvim-lspconfig",
  },

  -- git
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
  "tpope/vim-rhubarb",

  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = "markdown",
  },

  -- others
  "tpope/vim-sleuth",
  { "folke/neodev.nvim", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
  { "j-hui/fidget.nvim", config = true },
}
