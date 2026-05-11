vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>e", ":Neotree toggle left<CR>")
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")