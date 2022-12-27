local highlights = require("nord").bufferline.highlights({
  italic = true,
  bold = true,
})

require("bufferline").setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
    diagnostics = "nvim_lsp",
  },
  highlights = highlights,
})
