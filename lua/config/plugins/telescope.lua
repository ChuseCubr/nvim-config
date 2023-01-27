local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = { "<leader>", "<C-p>" },
}

function M.config()
  require("telescope").setup({})
  -- taken from kickstart.nvim
  pcall(require("telescope").load_extension, "fzf")

  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
  vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
  vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer]" })

  vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
  vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
  vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
  vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find within git project" })
end

return M
