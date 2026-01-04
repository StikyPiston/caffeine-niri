-- Shorthands
local map  = vim.keymap.set
local opts = { noremap = true, silent = true }
local noop = function() end

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
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99

vim.loader.enable()

-- Unbind things
map({ "n", "v", "o" }, "<Up>",    noop)
map({ "n", "v", "o" }, "<Down>",  noop)
map({ "n", "v", "o" }, "<Left>",  noop)
map({ "n", "v", "o" }, "<Right>", noop)
map("n",               "v",       "<C-v>")

map({ "n", "v", "o" }, "h", noop)
map({ "n", "v", "o" }, "j", noop)
map({ "n", "v", "o" }, "k", noop)
map({ "n", "v", "o" }, "l", noop)
map({ "n", "v", "o" }, "i", noop)

-- Bind IJKL as movement keys
map({ "n", "v", "o" }, "i", "k")
map({ "n", "v", "o" }, "k", "j")
map({ "n", "v", "o" }, "j", "h")
map({ "n", "v", "o" }, "l", "l")

-- Bindings
map('n', ';',          'i', opts)
map('i', '<A-o>',      '<C-x><C-o>', opts)
map('n', 'tT',         ':Oil<CR>')
map('n', 'fF',         function() require("telescope.builtin").find_files() end)
map('n', 'fG',         function() require("telescope.builtin").live_grep() end)
map('n', 'pP',         ':RenderMarkdown toggle<CR>')
map('n', 'hH',         ':tabNext<CR>')
map('n', 'hE',         ':tabnew<CR>')
map('n', 'hK',         vim.cmd.split)
map('n', 'hL',         vim.cmd.vsplit)
map('n', '<C-Up>',     '<C-w>k')
map('n', '<C-Down>',   '<C-w>j')
map('n', '<C-Left>',   '<C-w>h')
map('n', '<C-Right>',  '<C-w>l')
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
map('n', '<leader>mo', ':MarkmapOpen')
map('n', '<leader>ms', ':MarkmapSave')
map('n', '<leader>r',  ':%s/')
map('n', '<leader>sp', ':StudytoolsPomodoro 25 5<CR>')
map('n', '<leader>sP', ':StudytoolsPomodoroStatus<CR>')
map('n', '<leader>bb', ':StudytoolsBlurt<CR>')
map('n', '<C-Up>',     function() require("multicursor-nvim").lineAddCursor(-1) end)
map('n', '<C-Down>',   function() require("multicursor-nvim").lineAddCursor(1) end)
map('n', ',',          function() require("multicursor-nvim").clearCursors() end)
map('n', '<leader>cs', ':Cheaty<CR>')
map('n', '<leader>cf', ':Coinflip<CR>')
map('n', '<leader>ft', ':FloatermToggle<CR>')
map('n', '<leader>hh', ':Huefy<CR>')
map('n', '<leader>hs', ':Shades<CR>')

-- Packing it up in here :P

-- > Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- > Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
		{ "neovim/nvim-lspconfig" },
		{ "mason-org/mason.nvim", config = function() require("mason").setup() end },
		{ "nvim-tree/nvim-web-devicons" },
		{ "stevearc/oil.nvim", config = function() require("oil").setup() end },
		{ "nvim-mini/mini.nvim", config = function()
				require("mini.icons").setup()
				require("mini.tabline").setup()
				require("mini.notify").setup()
			end
		},
		{ "oxy2dev/markview.nvim" },
		{ "folke/flash.nvim", opts = {}, event = "VeryLazy", keys = {
				{ "<C-s>", mode = { "n", "x", "o", "v" }, function() require("flash").jump() end }
			}
		},
		{ "gisketch/triforce.nvim", config = function() require("triforce").setup() end },
		{ "nvzone/volt" },
		{ "lukas-reineke/indent-blankline.nvim", config = function() require("ibl").setup() end },
		{ "soulis-1256/eagle.nvim", opts = {
				keyboard_mode = true,
				mouse_mode    = true
			}
		},
		{ "stephansama/fzf-nerdfont.nvim", cmd = "FzfNerdfont" },
		{ "ibhagwan/fzf-lua" },
		{ "nvzone/typr", cmd = { "Typr", "TyprStats" } },
		{ "apple/pkl-neovim" },
		{ "charmbracelet/tree-sitter-vhs" },
		{ "echaya/neowiki.nvim", opts = {
				wiki_dirs = {
					{ name = "School", path = "~/Notebooks/School" }
				}
			}
		},
		{ "nvim-lualine/lualine.nvim" },
		{ "dstein64/vim-startuptime", cmd = "StartupTime" },
		{ "brenoprata10/nvim-highlight-colors", config = function() require("nvim-highlight-colors").setup({}) end },
		{ "kdheepak/lazygit.nvim", cmd = "LazyGit" },
		{ "stikypiston/coinflip.nvim", cmd = { "Coinflip" }, config = function() require("coinflip").setup() end },
		{ "sqwxl/playdate.nvim", opts = {
				playdate_sdk_path = "/home/distrorockhopper/Documents/PlaydateSDK-3.0.2",
				build = {
					source_dir = "src",
					output_dir = "build.pdx"
				}
			},
			cmd = { "PlaydateBuild", "PlaydateBuildRun", "PlaydateRun", "PlaydateSetup" }
		},
		{ "Zeioth/markmap.nvim", opts = {
				build = "yarn global add markmap-cli",
				cmd   = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
				opts  = {
					html_output  = "/tmp/markmap.html",
					hide_toolbar = false,
					grace_period = 3600000
				},
				lazy = true,
				config = function(_, opts) require("markmap").setup(opts) end
			}
		},
		{ "saghen/blink.cmp", build = "cargo build --release", config = function() require("blink.cmp").setup() end },
		{ "folke/lazydev.nvim", ft = "lua", opts = {}, enabled = true },
		{ "piersolenski/skifree.nvim", cmd = "SkiFree" },
		{ "chentoast/marks.nvim", event = "VeryLazy" },
		{ "stikypiston/cheaty.nvim",
			config = function() require("cheaty").setup({
				cheatsheet = {
					"# Cheatsheet",
					"",
					"## Basics",
					"- gq         : Wrap to 80-character long lines",
					"- : [visual] : do the '<,'> thing",
					"- g??        : ROT13 the current line for some reason",
					"- <leader>r  : :%s/",
					"- ~          : Toggle case of character under cursor",
					"",
					"## Marks",
					"- m[letter]  : Create mark of that letter",
					"- m,         : Create next available mark",
					"- '[letter]  : Go to mark of that letter",
					"- m<         : Go to previous mark",
					"- m>         : Go to next mark",
					"- m.         : Go to last-edited line",
					"- :delmark x : Delete mark of that letter",
					"",
					"## NeoWiki",
					"- <leader>ow : Open NeoWiki",
					"- <leader>oW : Open floating NeoWiki",
					"- <leader>ms : Open Mindmap of current file",
					"- <BS>       : Go back to previous file",
					"",
					"## Studytools",
					"- <leader>sp : Start Pomodoro timer (25/5 minute intervals)",
					"- <leader>sP : Pomodoro timer status",
					"- <leader>bb : Start blurting buffer",
					"",
					"## Folding",
					"- zc         : Fold",
					"- zM         : Fold all",
					"- zo         : Unfold",
					"- zO         : Unfold all under cursor",
					"- zr         : Unfold all one level",
					"- zf         : Create fold",
					"- za         : Toggle fold under cursor",
					"",
					"## Floaterminal",
					"- <leader>ft : Open floating terminal",
					"- <C-h>      : Focus sidebar",
					"- <C-l>      : Focus terminal",
					"- <C-j>      : Next terminal",
					"- <C-k>      : Previous terminal",
					"",
					"## Colour tools",
					"- <leader>hh : Hue menu",
					"- <leader>hs : Shades menu"
				}
			}) end,
			cmd = "Cheaty"
		},
		{ "lewis6991/gitsigns.nvim" },
		{ "m4xshen/autoclose.nvim", config = function() require("autoclose").setup() end },
		{ "stikypiston/studytools.nvim", config = function()
				require("studytools.inlineannotations").setup()
				require("studytools.pomodoro").setup()
				require("studytools.blurt").setup()
			end,
			ft  = "markdown",
			cmd = { "StudytoolsPomodoro", "StudytoolsPomodoroStatus", "StudytoolsPomodoroStop", "StudytoolsBlurt" }
		},
		{ "nvim-telescope/telescope.nvim", cmd = "Telescope" },
		{ "folke/snacks.nvim", opts = {
				image     = { enabled = true },
				quickfile = { enabled = true }
			}
		},
		{ "chrisgrieser/nvim-origami", event = "VeryLazy", opts = {
				autoFold = {
					enabled = false
				}
			}
		},
		{ "folke/which-key.nvim", event = "VeryLazy", opts = {
				preset = "helix",
				layout = {
					align = "right"
				}
			}
		},
		{ "jake-stewart/multicursor.nvim", config = function() require("multicursor-nvim").setup() end },
		{ "goolord/alpha-nvim" },
		{ "nvzone/minty", cmd = { "Shades", "Huefy" } },
		{ "nvzone/floaterm", cmd = { "FloatermToggle" } },
		{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} }
	  },
	install = { colorscheme = { "catppuccin-mocha" } },
	checker = { enabled = true },
})

-- Treesitter Setup
require("nvim-treesitter").install({ 'c', 'lua', 'swift', 'ruby', 'hyprlang', 'bash', 'go', 'gomod', 'gosum', 'kdl', 'markdown', 'markdown_inline', 'python', 'vhs', 'html', 'latex', 'yaml', 'typst', 'zsh' })
vim.api.nvim_create_autocmd('FileType', {
	pattern = { '<filetype>' },
	callback = function() vim.treesitter.start() end
})
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Theming
vim.cmd.colorscheme "catppuccin-mocha"
vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",    { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr",      { bg = "#1e2030" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "#1e2030" })

-- Plugin Setup
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
require("marks").setup({
	mappings = {
		set_next = "m,",
		next     = "m>",
		prev     = "m<"
	},

	builtin_marks = { "." }
})
local alpha = require("alpha")
local dash  = require("alpha.themes.dashboard")
dash.section.header.val ={
	"  _  _             _        ",
	" | \\| |___ _____ _(_)_ __   ",
	" | .` / -_) _ \\ V / | '  \\  ",
	" |_|\\_\\___\\___/\\_/|_|_|_|_| "
}
dash.section.buttons.val = {
	dash.button( "e", " New File",    ":ene<CR>" ),
	dash.button( "f", " Find File",   ":Telescope find_files<CR>"),
	dash.button( "w", " Open Wiki",   ":lua require('neowiki').open_wiki()<CR>" ),
	dash.button( "q", "󰩈 Exit Neovim", ":qa<CR>" )
}
alpha.setup(dash.opts)

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

-- > Go LSP
vim.lsp.enable("gopls")

-- Inline diagnostics
vim.diagnostic.config({
	virtual_text = true
})
