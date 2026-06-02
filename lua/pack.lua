vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/tpope/vim-fugitive",
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/max397574/startup.nvim",
    "https://github.com/karb94/neoscroll.nvim",
     "https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
})

-- mini files ----
local MiniFiles = require("mini.files")
MiniFiles.setup(
--     mappings = {
--         go_in = "<CR>",
--         go_in_plus = "L",
--         go_out = "_",
--         go_out_plus = "H",
--     },
)

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

---- mini notify ----
require("mini.notify").setup({
	-- only show messages
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

--- mini cmdline completion ---
require("mini.cmdline").setup({
    autocorrect = { enable = false }
})

--- mini surround ---
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

--- mini picker ---
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

-- keymaps
vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Grep word/Search word" })
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })

--- mini completions --- 
require("mini.completion").setup({
    lsp_completion = {
        auto_setup = true,
    }
})

--- mini snippets ---
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
    },
})
MiniSnippets.start_lsp_server({ match = false })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full Page New Tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split", })

-- newscroll --
require('neoscroll').setup({
  mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>', '<C-d>',
    '<C-b>', '<C-f>',
    '<C-y>', '<C-e>',
    'zt', 'zz', 'zb',
  },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  duration_multiplier = 1.0,   -- Global duration multiplier
  easing = 'linear',           -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  ignored_events = {           -- Events ignored while scrolling
      'WinScrolled', 'CursorMoved'
  },
})

--- startup screen ---
require("startup").setup({
    header = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 0,
content = {
            "          .  .                    ",
            "          |\\_|\\                   ",
            "          | a_a\\                  ",
            "          | | \"]                  ",
            "      ____| '-\\___                ",
            "     /.----.___.-'\\               ",
            "    //        _    \\              ",
            "   //   .-. (~v~) /|              ",
            "  |'|  /\\:  .--  / \\             ",
            " // |-/  \\_/____/\\/~|             ",
            "|/  \\ |  []_|_|_] \\ |            ",
            "| \\  | \\ |___   _\\ ]_}           ",
            "| |  '-' /   '.'  |               ",
            "| |     /    /|:  |               ",
            "| |     |   / |:  /\\              ",
            "| |     /  /  |  /  \\             ",
            "| |    |  /  /  |    \\            ",
            "\\ |    |/\\/  |/|/\\    \\          ",
            " \\|\\ |\\|  |  | / /\\/\\__\\        ",
            "  \\ \\| | /   | |__               ",
            "snd    / |   |____)               ",
            "       |_/                        ",
        },
        highlight = "Statement",
        default_color = "",
        oldfiles_amount = 0,
    },
    body = {
        type = "mapping",
        align = "center",
        fold_section = false,
        title = "Commands",
        -- margin = 5,
        content = {
            { " Find File",    "lua MiniPick.builtin.files()",                   "<leader>pf" },
            { " Recent Files", "lua require('mini.extra').pickers.oldfiles()",   "<leader>pr" },
            { " Grep",         "lua MiniPick.builtin.grep({})",                  "<leader>ps" },
            { " New File",     "enew",                                            "e" },
            { " Quit",         "quit",                                            "q" },
        },
        highlight = "String",
        default_color = "",
        oldfiles_amount = 0,
    },
    options = {
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = true,
        disable_statuslines = true,
        paddings = { 1, 1 },
    },
    mappings = {
        execute_command = "<CR>",
        open_file = "o",
        open_file_split = "<c-o>",
        open_section = "<TAB>",
        open_help = "?",
    },
    colors = {
        background = "#1f2227",
        folded_section = "#56b6c2",
    },
    parts = { "header", "body" },
})



-- Setup gitsigns.nvim
require("gitsigns").setup({
	current_line_blame = true,
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signs_staged = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
		end

		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next Hunk")

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev Hunk")

		map("n", "]H", function()
			gs.nav_hunk("last")
		end, "Last Hunk")
		map("n", "[H", function()
			gs.nav_hunk("first")
		end, "First Hunk")

		map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
		map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")

		map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
		map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
		map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
		map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
		map("n", "<leader>ghb", function()
			gs.blame_line({ full = true })
		end, "Blame Line")
		map("n", "<leader>ghB", function()
			gs.blame()
		end, "Blame Buffer")
		map("n", "<leader>ghd", gs.diffthis, "Diff This")
		map("n", "<leader>ghD", function()
			gs.diffthis("~")
		end, "Diff This ~")

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
})

-- Setup diffview.nvim
local actions = require("diffview.actions")

require("diffview").setup({
	diff_binaries = false,
	enhanced_diff_hl = true, -- Better diff highlighting
	use_icons = true,
	show_help_hints = true,
	watch_index = true,
	icons = {
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
		done = "✓",
	},
	view = {
		default = {
			layout = "diff2_horizontal",
			disable_diagnostics = true, -- Cleaner view
			winbar_info = true,
		},
		merge_tool = {
			layout = "diff3_horizontal", -- diff3_horizontal | diff3_vertical | diff3_mixed | diff4_mixed
			disable_diagnostics = true,
			winbar_info = true,
		},
		file_history = {
			layout = "diff2_horizontal",
			disable_diagnostics = true,
			winbar_info = true,
		},
	},
	file_panel = {
		listing_style = "tree",
		tree_options = {
			flatten_dirs = true,
			folder_statuses = "only_folded",
		},
		win_config = {
			position = "left",
			width = 40,
		},
	},
	file_history_panel = {
		log_options = {
			git = {
				single_file = {
					diff_merges = "combined",
				},
				multi_file = {
					diff_merges = "first-parent",
				},
			},
		},
		win_config = {
			position = "bottom",
			height = 15,
		},
	},
	keymaps = {
		disable_defaults = false,
		view = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diff view" } },

			-- Navigation
			{ "n", "]c", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "[c", actions.select_prev_entry, { desc = "Previous file" } },
			{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "[f", actions.select_prev_entry, { desc = "Previous file" } },
			-- more easy in macos
			{ "n", "<C-n>", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "<C-p>", actions.select_prev_entry, { desc = "Previous file" } },

			-- Toggle file panel
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },

			-- Conflict resolution
			{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
			{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
			{ "n", "<leader>cb", actions.conflict_choose("all"), { desc = "Choose BOTH" } },
			{ "n", "<leader>cx", actions.conflict_choose("none"), { desc = "Delete conflict" } },
			{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
			{ "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
			{ "n", "<C-j>", actions.next_conflict, { desc = "Next conflict" } },
			{ "n", "<C-k>", actions.prev_conflict, { desc = "Previous conflict" } },

			-- Keep useful defaults
			{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
			{ "n", "gf", actions.goto_file_edit, { desc = "Go to file" } },
		},
		diff3 = {
			-- Conflict resolution in 3-way diff
			{ { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Get from OURS" } },
			{ { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get from THEIRS" } },
		},
		file_panel = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
			{ "n", "o", actions.select_entry, { desc = "Open diff" } },
			{ "n", "l", actions.select_entry, { desc = "Open diff" } },
			{ "n", "R", actions.refresh_files, { desc = "Refresh" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
			{ "n", "i", actions.listing_style, { desc = "Toggle list/tree" } },
			{ "n", "-", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
			{ "n", "S", actions.stage_all, { desc = "Stage all" } },
			{ "n", "U", actions.unstage_all, { desc = "Unstage all" } },
			{ "n", "]c", actions.next_entry, { desc = "Next entry" } },
			{ "n", "[c", actions.prev_entry, { desc = "Previous entry" } },
		},
		file_history_panel = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
			{ "n", "o", actions.select_entry, { desc = "Open diff" } },
			{ "n", "l", actions.select_entry, { desc = "Open diff" } },
			{ "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
			{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
		},
	},
})

-- Git status / changed files view
vim.keymap.set("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "Diff: git status" })
-- File history views
vim.keymap.set("n", "<leader>gv", "<Cmd>DiffviewFileHistory<CR>", { desc = "Diff: repo history" })
vim.keymap.set("n", "<leader>gV", "<Cmd>DiffviewFileHistory %<CR>", { desc = "Diff: current file history" })

-- Visual mode: history of selected lines
vim.keymap.set("v", "<leader>gv", ":'<,'>DiffviewFileHistory<CR>", { desc = "Diff: selection history" })

-- Compare with revisions (prompts)
vim.keymap.set("n", "<leader>gc", function()
	vim.ui.input({ prompt = "Compare revision (ex. main, HEAD~5, main..HEAD): " }, function(refs)
		if refs and refs:match("%S") then
			vim.cmd(("DiffviewOpen %s"):format(refs))
		end
	end)
end, { desc = "Diff: compare revisions" })

vim.keymap.set("n", "<leader>gC", function()
	vim.ui.input({ prompt = "File history range (ex. HEAD~1, main..HEAD): " }, function(range)
		if range and range:match("%S") then
			vim.cmd(("DiffviewFileHistory --range=%s %%"):format(range))
		end
	end)
end, { desc = "Diff: file history with range" })

-- Compare two arbitrary files
vim.keymap.set("n", "<leader>g2", function()
	vim.ui.input({ prompt = "First file: " }, function(file1)
		if not file1 or not file1:match("%S") then
			return
		end
		vim.ui.input({ prompt = "Second file: " }, function(file2)
			if file2 and file2:match("%S") then
				vim.cmd(("tabnew | e %s | diffthis | vsplit %s | diffthis"):format(file1, file2))
			end
		end)
	end)
end, { desc = "Diff: Compare 2 files" })
