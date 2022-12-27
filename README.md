# nvim-config

My completely remade and revamped Neovim dotfiles.

Stiched together bits and pieces I liked from:

- [The Primeagen's dotfiles](https://github.com/ThePrimeagen/init.lua). (Also check out his [Youtube video](https://youtu.be/w7i4amO_zaE) on it if you want.)
- [The Kickstart.nvim project](https://github.com/nvim-lua/kickstart.nvim)
- [LunarVim](https://www.lunarvim.org/)

## Requirements

- Neovim 0.8.0 or higher.

No need to install Packer or a package manager. [lazy.nvim](https://github.com/folke/lazy.nvim) automatically installs itself.

## Features

This sets up:

- LSP with [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim)
  - some tweaks for lua configs, including [neodev](https://github.com/folke/neodev.nvim)
  - installs null-ls (doesn't set up much though)
- Treesitter
- Telecope
- Git integration
- UI stuff
  - Bufferline
  - Lualine
  - Navic
  - Indent Blankline
- Markdown
  - [Headlines](https://github.com/lukas-reineke/headlines.nvim) and linting
