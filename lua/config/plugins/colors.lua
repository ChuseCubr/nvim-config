local versions = {
  arcticicestudio = {
    "arcticicestudio/nord-vim",
    config = function()
      vim.g.nord_cursor_line_number_background = false
      vim.g.nord_uniform_status_lines = false
      vim.g.nord_bold_vertical_split_line = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = true
      vim.g.nord_italic = true
      vim.g.nord_italic_comments = true
      vim.g.nord_underline = true
    end
  },
  shaunsingh = {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_contrast = false
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_cursorline_transparent = false
      vim.g.nord_enable_sidebar_background = false
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = true
    end
  }
}

local function get_nord_opts(version)
  if versions[version] == nil then
    return versions["arcticicestudio"]
  end
  return versions[version]
end

local M = get_nord_opts(vim.g.nord_version)

return M
