vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center cursor
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- void register
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP', { desc = "[P]aste from system" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to system" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "[Y]ank to system" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete (no yank)" })

-- diagnostics
vim.keymap.set("n", "<space>ce", vim.diagnostic.open_float, { desc = "[E]rrors" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<space>cl", vim.diagnostic.setloclist, { desc = "To [L]ocation list" })
vim.keymap.set("n", "<space>cq", vim.diagnostic.setqflist, { desc = "To [Q]uickfix list" })

-- lists
vim.keymap.set("n", "gq", "<cmd>copen<cr>", { desc = "[Q]uickfix list" })
vim.keymap.set("n", "gl", "<cmd>lopen<cr>", { desc = "[L]ocation list" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz", { desc = "Prev quickfix entry" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix entry" })
vim.keymap.set("n", "[Q", "<cmd>cpf<cr>zz", { desc = "Prev quickfix file" })
vim.keymap.set("n", "]Q", "<cmd>cnf<cr>zz", { desc = "Next quickfix file" })
vim.keymap.set("n", "[l", "<cmd>lprev<cr>zz", { desc = "Prev location entry" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>zz", { desc = "Next location entry" })
vim.keymap.set("n", "[L", "<cmd>lpf<cr>zz", { desc = "Prev location file" })
vim.keymap.set("n", "]L", "<cmd>lnf<cr>zz", { desc = "Next location file" })
