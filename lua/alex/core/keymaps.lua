vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>e", ":Neotree toggle left<CR>")
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

keymap.set("n", "<A-Down>", ":m .+1<CR>==")
keymap.set("n", "<A-Up>", ":m .-2<CR>==")