local M = {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    "<leader>t"
  },
}

function M.config()
  local shell
  if vim.fn.has("unix") or vim.fn.has("macunix") then
    shell = "/usr/bin/env bash"
  else
    shell = "\"/Program Files/PowerShell/7/pwsh.exe\" -NoLogo"
  end

  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,

    float_opts = {
      border = "curved",
    },
    shell = shell,
  })

  vim.keymap.set(
    "n",
    "<leader>th",
    "<cmd>ToggleTerm direction=horizontal<cr>"
  )

  vim.keymap.set(
    "n",
    "<leader>tv",
    "<cmd>ToggleTerm direction=vertical<cr>"
  )

  vim.keymap.set(
    "n",
    "<leader>tf",
    "<cmd>ToggleTerm direction=float<cr>"
  )
end

return M
