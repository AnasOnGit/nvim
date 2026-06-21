vim.g.mapleader = " "

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- grep selected text across project with telescope
vim.keymap.set("v", "<leader>sw", function()
	local saved = vim.fn.getreg("v")
	vim.cmd('noau normal! "vy"')
	local selection = vim.fn.getreg("v")
	vim.fn.setreg("v", saved)
	require("telescope.builtin").grep_string({ search = selection })
end, { desc = "[S]earch selected [W]ord" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

-- Option (Alt) + Enter -> new line below current line
vim.keymap.set("n", "<A-CR>", "o<Esc>", {
	desc = "Insert line below",
})

-- Shift + Enter -> new line above current line
vim.keymap.set("n", "<S-CR>", "O<Esc>", {
	desc = "Insert line above",
})
-- Scroll up ctrl + s
vim.keymap.set("n", "<C-s>", "<C-u>", { desc = "Scroll up" })

-- nvim-ufo folding
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
-- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
-- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with level" })
-- vim.keymap.set("n", "K", function()
--     local winid = require("ufo").peekFoldedLinesUnderCursor()
--     if not winid then
--         vim.lsp.buf.hover()
--     end
-- end, { desc = "Peek fold / LSP hover" })
