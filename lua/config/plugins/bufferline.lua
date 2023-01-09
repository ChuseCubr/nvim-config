local M = { "akinsho/bufferline.nvim" }

function M.config()
  local setup_bufferline = function()
    local has_nord, nord = pcall(require, "nord")
    local using_nord = vim.g.colors_name == "nord"
    local highlights = {}

    if has_nord and using_nord then
      highlights = nord.bufferline.highlights({
        italic = true,
        bold = true,
      })
    end

    require("bufferline").setup({
      options = {
        mode = "tabs",
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
end

return M
