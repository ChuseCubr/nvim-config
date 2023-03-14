return {
  -- file browser
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function ()
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
      require("nvim-tree").setup()
    end,
  },

  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = "markdown",
  },

  -- others
  "tpope/vim-sleuth",
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
}
