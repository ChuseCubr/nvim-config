local M = {
  -- "articicestudio/nord-vim",
  "shaunsingh/nord.nvim",
}

function M.config()
  -- "official" (articicestudio) version
  -- vim.g.nord_cursor_line_number_background = false
  -- vim.g.nord_uniform_status_lines = false
  -- vim.g.nord_bold_vertical_split_line = false
  -- vim.g.nord_uniform_diff_background = true
  -- vim.g.nord_bold = true
  -- vim.g.nord_italic = true
  -- vim.g.nord_italic_comments = true
  -- vim.g.nord_underline = true

  -- shaunsingh version
  vim.g.nord_contrast = false
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_enable_sidebar_background = false
  vim.g.nord_italic = true
  vim.g.nord_uniform_diff_background = true
  vim.g.nord_bold = true

  vim.opt.termguicolors = true
end

return M
