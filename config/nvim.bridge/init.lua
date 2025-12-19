-- Shorthands
local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Options
vim.o.signcolumn     = "yes"
vim.o.wrap           = false
vim.o.tabstop        = 4
vim.o.number         = true
vim.o.smartindent    = true
vim.o.swapfile       = false
vim.o.winborder      = "rounded"
vim.o.clipboard      = "unnamedplus"
vim.o.mousemoveevent = true
vim.o.number         = true
vim.o.shiftwidth     = 4
vim.g.mapleader      = " "

-- Bindings
map('n', ';',          'i', opts)
map('i', '<A-o>',      '<C-x><C-o>', opts)
map('n', 'tT',         ':Oil<CR>')
map('n', 'fF',         ':Pick files<CR>')
map('n', 'dD',         ':Dashboard<CR>')
map('n', 'pP',         ':RenderMarkdown toggle<CR>')
map('n', 'hH',         ':tabNext<CR>')
map('n', 'hE',         ':tabedit ')
map('n', 'gO',         ':Obsidian')
map('n', 'hK',         vim.cmd.split)
map('n', 'hL',         vim.cmd.vsplit)
map('n', '<C-Up>',     '<C-w>k')
map('n', '<C-Down>',   '<C-w>j')
map('n', '<C-Left>',   '<C-w>h')
map('n', '<C-Right>',  '<C-w>l')
map('n', '<C-s>',      function() require('flash').jump() end)
map('n', '<C-i>',      ':FzfNerdfont<CR>')
map('n', '<C-b>',      function() vim.pack.update() end)
map('n', '<leader>ow', function() require("neowiki").open_wiki() end)
map('n', '<leader>oW', function() require("neowiki").open_wiki_floating() end)
map('n', '<leader>tp', ':Triforce profile<CR>')
map('n', '<leader>lg', ':LazyGit<CR>')
map('n', '<leader>w',  ':w<CR>')
map('n', '<leader>q',  ':q<CR>')
map('n', '<leader>so', ':so<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>cf', function() require("coinflip").flip() end)
map('n', '<leader>mo', ':MarkmapOpen')
map('n', '<leader>ms', ':MarkmapSave')

-- Packing it up in here :P
vim.pack.add({
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/gisketch/triforce.nvim",
	"https://github.com/nvzone/volt",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/soulis-1256/eagle.nvim",
	"https://github.com/stephansama/fzf-nerdfont.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvzone/typr",
	"https://github.com/apple/pkl-neovim",
	"https://github.com/charmbracelet/tree-sitter-vhs",
	"https://github.com/echaya/neowiki.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/dstein64/vim-startuptime",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/StikyPiston/coinflip.nvim",
	"https://github.com/NStefan002/2048.nvim",
	"https://github.com/sqwxl/playdate.nvim",
	"https://github.com/3rd/image.nvim",
	"https://github.com/Zeioth/markmap.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/piersolenski/skifree.nvim"
})

-- Treesitter Setup
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "swift", "ruby", "hyprlang", "bash", "go", "gomod", "gosum", "kdl", "pkl", "markdown", "markdown_inline", "python", "vhs", "html", "latex", "yaml", "typst" },

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
	},

	indent = {
		enable = true,
	},
})

-- Theming
vim.cmd.colorscheme "catppuccin-mocha"
vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",    { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr",      { bg = "#1e2030" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "#1e2030" })

-- Plugin Setup
require("mason").setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.tabline").setup()
require("mini.starter").setup()
require("mini.notify").setup()
require("oil").setup()
require("render-markdown").setup()
require('ibl').setup()
require('eagle').setup({
	keyboard_mode = true,
	mouse_mode    = true
})
require("neowiki").setup({
	wiki_dirs = {
		{ name = "School", path = "~/Notebooks/School" }
	}
})
require("lualine").setup({
	options = {
		section_separators   = { right = "", left = "" },
		compenent_separators = { right = "", left = "" }
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = {},
		lualine_x = { require("triforce.lualine").level, "filetype", "location", "diff" },
		lualine_y = { "lsp_status", "diagnostics" },
		lualine_z = {}
	}
})
require("triforce").setup()
require("nvim-highlight-colors").setup()
require("2048").setup()
require("playdate").setup({
	playdate_sdk_path = "/home/distrorockhopper/Documents/PlaydateSDK-3.0.2",
	build = {
		source_dir = "src",
		output_dir = "build.pdx"
	}
})
require("image").setup()
require("markmap").setup({
	html_output  = "/tmp/markmap.html",
	hide_toolbar = false,
	grace_period = 3600000
})
require("blink.cmp").setup()
require("lazydev").setup()

-- Hijinks in LSP land

-- > Lua language server
vim.lsp.config("lua_ls", {
	cmd = { '/usr/sbin/lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
		'.git',
	},
})
vim.lsp.enable("lua_ls")

-- > Ruby LSP
vim.lsp.config("ruby-lsp", {
	cmd          = { "ruby-lsp" },
	filetypes    = { 'ruby', 'eruby' },
	root_markers = { 'Gemfile', '.git' },
	init_options = { formatter = 'auto', },
	reuse_client = function(client, config)
		config.cmd_cwd               =  config.root_dir
		return client.config.cmd_cwd == config.cmd_cwd
	end,
})
vim.lsp.enable("ruby-lsp")

-- > Crystal LSP
vim.lsp.config("crystalline", {
	cmd          = { 'crystalline' },
	filetypes    = { 'crystal' },
	root_markers = { 'shard.yml', '.git' }
})
vim.lsp.enable("crystalline")

-- > Hyprlang LSP
vim.lsp.config('hyprls', {
	cmd          = { 'hyprls', '--stdio' },
	filetypes    = { 'hyprlang' },
	root_markers = { '.git' }
})
vim.lsp.enable("hyprls")

-- > Fish LSP
vim.lsp.config("fish-lsp", {
	cmd          = { 'fish-lsp', 'start' },
	filetypes    = { 'fish' },
	root_markers = { 'config.fish', '.git' },
})
vim.lsp.enable("fish-lsp")

-- > CoffeeScript LSP
vim.lsp.config("coffeesense", {
	cmd          = { 'coffeesense-language-server', '--stdio' },
	filetypes    = { 'coffee' },
	root_markers = { 'package.json' },
})
vim.lsp.enable("coffeesense")

-- > Rust LSP
vim.lsp.enable("rust_analyzer")

-- > Zig LSP
vim.lsp.enable("zls")

-- > MCFunction LSP
vim.lsp.enable("spyglassmc_language_server")

-- > Typst LSP
vim.lsp.enable("tinymist")

-- > Python LSP
vim.lsp.enable("pyright")

-- > Swift LSP
vim.lsp.enable("sourcekit")
