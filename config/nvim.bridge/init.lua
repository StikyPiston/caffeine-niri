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
vim.o.scrolloff      = 999

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
map('n', '<leader>lg', function() Snacks.lazygit() end)
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
map('n', '<A-Up>',     function() require("multicursor-nvim").lineAddCursor(-1) end)
map('n', '<A-Down>',   function() require("multicursor-nvim").lineAddCursor(1) end)
map('n', ',',          function() require("multicursor-nvim").clearCursors() end)
map('n', '<leader>cs', ':Cheaty<CR>')
map('n', '<leader>cf', ':Coinflip<CR>')
map('n', '<leader>lz', ':Lazy<CR>')
map('n', '<leader>ld', ':Trouble diagnostics<CR>')
map('n', '<leader>ot', function() Snacks.terminal.open() end)
map('n', '<leader>os', function() Snacks.scratch() end)

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
		{ "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate", config = function()
			require("nvim-treesitter").install({ 'c', 'lua', 'swift', 'ruby', 'hyprlang', 'bash', 'go', 'gomod', 'gosum', 'kdl', 'markdown', 'markdown_inline', 'python', 'vhs', 'html', 'latex', 'yaml', 'typst', 'zsh' })
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { '<filetype>' },
				callback = function() vim.treesitter.start() end
			})
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end },
		{ "neovim/nvim-lspconfig" },
		{ "mason-org/mason.nvim", config = function() require("mason").setup() end },
		{ "nvim-tree/nvim-web-devicons" },
		{ "stevearc/oil.nvim", config = function() require("oil").setup() end },
		{ "nvim-mini/mini.nvim", config = function()
				require("mini.icons").setup()
			end
		},
		{ "oxy2dev/markview.nvim", ft = { "markdown", "html", "latex", "typst", "yaml" } },
		{ "folke/flash.nvim", opts = {}, event = "VeryLazy", keys = {
				{ "<C-s>", mode = { "n", "x", "o", "v" }, function() require("flash").jump() end }
			}
		},
		{ "gisketch/triforce.nvim", config = function() require("triforce").setup() end },
		{ "nvzone/volt" },
		{ "stephansama/fzf-nerdfont.nvim", cmd = "FzfNerdfont" },
		{ "ibhagwan/fzf-lua" },
		{ "nvzone/typr", cmd = { "Typr", "TyprStats" } },
		{ "apple/pkl-neovim", ft = "pkl" },
		{ "charmbracelet/tree-sitter-vhs", ft = "vhs" },
		{ "echaya/neowiki.nvim", opts = {
				wiki_dirs = {
					{ name = "School", path = "~/Notebooks/School" }
				}
			}
		},
		{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
		{ "dstein64/vim-startuptime", cmd = "StartupTime" },
		{ "brenoprata10/nvim-highlight-colors", config = function() require("nvim-highlight-colors").setup({}) end },
		{ "stikypiston/coinflip.nvim", cmd = { "Coinflip" }, config = function() require("coinflip").setup() end },
		{ "Zeioth/markmap.nvim", opts = {
				build = "yarn global add markmap-cli",
				cmd   = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
				opts  = {
					html_output  = "/tmp/markmap.html",
					hide_toolbar = false,
					grace_period = 3600000
				},
				lazy   = true,
				config = function(_, opts) require("markmap").setup(opts) end,
				ft     = "markdown"
			}
		},
		{ "saghen/blink.cmp", build = "cargo build --release", config = function() require("blink.cmp").setup() end, event = { "InsertEnter", "CmdlineEnter" } },
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
					"## LSP",
					"- <leader>ld : Trouble diagnostics",
					"",
					"## Terminal",
					"- <leader>ot : Open terminal split"
				}
			}) end,
			cmd = "Cheaty"
		},
		{ "lewis6991/gitsigns.nvim", event = "BufReadPre" },
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
				quickfile = { enabled = true },
				scroll    = { enabled = true, animate = { duration = { step = 1, total = 10 } } },
				notifier  = { enabled = true },
				lazygit   = { enabled = true },
				indent    = { enabled = true },
				terminal  = { enabled = true },
				scratch   = { enabled = true },
				dashboard = { enabled = true,
					sections = {
						{ section = "header" },
						{
							gap     = 1,
							padding = 1,
							indent  = 2,
							icon    = "󰥔",
							title   = "Recent Files",
							section = "recent_files",
						},
						{
							pane    = 2,
							gap     = 1,
							padding = 1,
							{ icon = "", key = "e", desc = "New File",    action = ":ene" },
							{ icon = "", key = "f", desc = "Find File",   action = ":Telescope find_files" },
							{ icon = "", key = "w", desc = "Open Wiki",   action = ":lua require('neowiki').open_wiki()" },
							{ icon = "󰏗", key = "p", desc = "Plugins",     action = ":Lazy" },
							{ icon = "󰩈", key = "q", desc = "Quit Neovim", action = ":qa" },
						},
						{
							pane    = 2,
							gap     = 1,
							padding = 1,
							icon    = "",
							title   = "GitHub Status",
							section = "terminal",
							cmd     = "gh status",
						},
						{ section = "startup" },
					}
				},
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
		{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
		{ "romgrk/barbar.nvim", init = function() vim.g.barbar_auto_setup = false end, opts = {} },
		{ "folke/trouble.nvim", opts = {}, cmd = "Trouble" },
		{ "stikypiston/smudge.nvim", opts = { length = 6 } },
		{ "folke/noice.nvim", opts = {
				notify    = { enabled = false },
				lsp       = { progress = { enabled = false }, hover = { enabled = false }, signature = { enabled = false }, message = { enabled = false } },
				messages  = { enabled = false },
				popupmenu = { enabled = false },
			}
		},
		{ "l3mon4d3/luasnip", dependencies = { "rafamadriz/friendly-snippets" } }
	  },
	install = { colorscheme = { "catppuccin-mocha" } },
	checker = { enabled = true },
})

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

-- Autocmds
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {}
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "/", "-", "\\", "|" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap      = true
    vim.opt_local.linebreak = true
	vim.opt_local.spell     = true
  end,
})

-- Hijinks in LSP land
local function enableLSP(ft, server)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		callback = function()
			vim.schedule(function()
				if vim.lsp.config[server] then
					vim.lsp.enable(server)
				end
			end)
		end
	})
end

vim.api.nvim_create_user_command(
	"MasonBootstrap",
	function()
		vim.cmd("MasonInstall bash-language-server coffeesense-language-server crystalline fish-lsp gopls hyprls kdlfmt lua-language-server marksman pyright ruby-lsp spyglassmc-language-server tinymist zls")
	end,
	{}
)

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
enableLSP("lua", "lua_ls")

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
enableLSP("ruby", "ruby-lsp")

-- > Crystal LSP
vim.lsp.config("crystalline", {
	cmd          = { 'crystalline' },
	filetypes    = { 'crystal' },
	root_markers = { 'shard.yml', '.git' }
})
enableLSP("crystal", "crystalline")

-- > Hyprlang LSP
vim.lsp.config('hyprls', {
	cmd          = { 'hyprls', '--stdio' },
	filetypes    = { 'hyprlang' },
	root_markers = { '.git' }
})
enableLSP("hyprlang", "hyprls")

-- > Fish LSP
vim.lsp.config("fish-lsp", {
	cmd          = { 'fish-lsp', 'start' },
	filetypes    = { 'fish' },
	root_markers = { 'config.fish', '.git' },
})
enableLSP("fish", "fish-lsp")

-- > CoffeeScript LSP
vim.lsp.config("coffeesense", {
	cmd          = { 'coffeesense-language-server', '--stdio' },
	filetypes    = { 'coffee' },
	root_markers = { 'package.json' },
})
enableLSP("coffeescript", "coffeesense")

-- > Rust LSP
enableLSP("rust", "rust_analyzer")

-- > Zig LSP
enableLSP("zig", "zls")

-- > MCFunction LSP
enableLSP("mcfunction", "spyglassmc_language_server")

-- > Typst LSP
enableLSP("typst", "tinymist")

-- > Python LSP
enableLSP("python", "pyright")

-- > Swift LSP
enableLSP("swift", "sourcekit")

-- > Go LSP
enableLSP("go", "gopls")

-- > Markdown LSP
enableLSP("markdown", "marksman")

-- > Bash LSP
enableLSP("bash", "bash-language-server")

-- Inline diagnostics
vim.diagnostic.config({
	virtual_text = true
})
