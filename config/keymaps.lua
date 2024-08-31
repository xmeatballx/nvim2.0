local unmap = vim.keymap.del
local map = vim.keymap.set

--- This fixes an issue with the vim-tmux-navigator + nvchad in which the base nvchad
--- mapping were conflicting with vim-tmux-navigator ones.
unmap("n", "<c-h>")
unmap("n", "<c-j>")
unmap("n", "<c-k>")
unmap("n", "<c-l>")

map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>")
map("n", "<c-\\>", "<cmd>:TmuxNavigatePrevious<cr>")
