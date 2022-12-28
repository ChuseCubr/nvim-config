return {
  -- code context
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },

  -- git
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    }
  },
  "tpope/vim-rhubarb",

  -- others
  "tpope/vim-sleuth",
  { "folke/neodev.nvim", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
  { "j-hui/fidget.nvim", config = true },
}
