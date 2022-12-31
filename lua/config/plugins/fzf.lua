local M = { "nvim-telescope/telescope-fzf-native.nvim" }

if vim.fn.has("unix") or vim.fn.has("macunix") then
  M.build = "make"
  M.cond = vim.fn.executable("make") == 1
else
  M.build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
end

return M
