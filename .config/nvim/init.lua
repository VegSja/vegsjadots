vim.g.neovide_scale_factor = 1.3
vim.g.vimtex_text_prop_conceal = 0
vim.g.vimtex_syntax_conceal_disable = 1
vim.wo.conceallevel = 0
-- bootstrap lazy.nvim, LazyVim and your plugins
vim.env.PATH = vim.env.PATH .. ":~/.local/share/nvim/mason/bin/"
require("config.lazy")
