-- BASIC OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- LAZY PATH
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- LAZY SETUP
require("lazy").setup({

  -- FILE EXPLORER
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("nvim-tree").setup({
        view = { width = 32, side = "left" },
        renderer = { group_empty = true, highlight_git = true },
        filters = { dotfiles = false, custom = {".git"} },
        git = { enable = true },
        update_focused_file = { enable = true, update_root = false }
      })
      vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true })
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { silent = true })
    end
  },

  -- FUZZY FINDER
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"}
  },

  -- SYNTAX HIGHLIGHT
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- AUTO PAIRS
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      -- integração com nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  },

  -- DRACULA THEME
  {
    "dracula/vim",
    name = "dracula",
    lazy = false,
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "mfussenegger/nvim-jdtls" },

  -- AUTOCOMPLETE
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer"
    }
  }

})

-- THEME APPLY (AFTER LAZY LOADING)
pcall(vim.cmd, "colorscheme dracula")

-- LSP CAPABILITIES
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript
vim.lsp.config('ts_ls', { capabilities = capabilities })
vim.lsp.enable('ts_ls')

-- C#
vim.lsp.config('omnisharp', { capabilities = capabilities })
vim.lsp.enable('omnisharp')

-- AUTOCOMPLETE CONFIG
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
  }
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() require("cmp").abort() end
})

-- OPEN EXPLORER
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
  end
})

-- TELESCOPE SHORTCUTS
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>jj", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
