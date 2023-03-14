local function jupytext_sync(opts)
  local filename = vim.fn.expand("%")
  local status, data = pcall(
    vim.fn.jobstart,
    { "jupytext", "--sync", filename }
  )
  if status then
    print("Synced with Jupytext")
  else
    print("Error: " .. data)
  end
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("JupytextSync", { clear = true }),
  pattern = "*.ju.py",
  callback = jupytext_sync,
})
