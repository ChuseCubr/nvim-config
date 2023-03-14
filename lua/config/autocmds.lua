-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- remove background
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("RemoveBackground", { clear = true }),
  callback = function()
    if not vim.g.transparent_background then return end
    local groups = {
      "Normal",
      "NormalFloat",
      "NonText",
      "LineNr",
      "VertSplit",
      "EndOfBuffer",
      "SignColumn",
      "SpellBad",
      "SpellCap",
      "SpellRare",
      "SpellLocal",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_command(
        string.format("hi %s ctermbg=None guibg=None", group)
      )
    end
  end
})
