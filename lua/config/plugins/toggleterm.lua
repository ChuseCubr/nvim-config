local M = {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    "<c-\\>",
    "<leader>t"
  },
}

function M.config()
  local system_shell

  if (vim.fn.has("unix") == 1
      or vim.fn.has("macunix") == 1) then
    system_shell = "/usr/bin/env bash"
  else
    system_shell = "\"C:/Program Files/PowerShell/7/pwsh.exe\" -NoLogo"
  end

  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,

    open_mapping = [[<c-\>]],
    direction = "vertical",
    float_opts = {
      border = "curved",
    },
    shell = system_shell,
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
