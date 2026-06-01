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
    "https://github.com/karb94/neoscroll.nvim"
})

-- mini files ----
local MiniFiles = require("mini.files")
MiniFiles.setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H",
    },
})

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
