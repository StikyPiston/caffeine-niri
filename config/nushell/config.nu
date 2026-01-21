source catppuccin_mocha.nu
source starship.nu
source zoxide.nu

$env.config.show_banner = false

alias l  = eza --icons=always --group-directories-first
alias la = l -a
alias ll = l -a1

alias mv    = mv -v
alias cp    = cp -v
alias rm    = rm -v
alias mkdir = mkdir -v
alias tree  = tree -LC 1
alias ncdu  = ncdu --color dark --show-percent
alias clear = /bin/clear -x

alias nv = nvim

alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gd = git diff
alias gb = git blame

alias sb  = soft browse
alias lg  = lazygit
alias man = tldr
alias sf  = spf

$env.PATH = ( $env.PATH | append "$env.HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin" )
$env.PATH = ( $env.PATH | append "$env.HOME/.local/share/bob/nvim-bin" )
$env.PATH = ( $env.PATH | append "$env.HOME/Documents/PlaydateSDK-3.0.2/bin" )
$env.PATH = ( $env.PATH | append "$env.HOME/Applications" )
$env.PATH = ( $env.PATH | append "$env.HOME/.scripts" )
$env.PATH = ( $env.PATH | append "$env.HOME/.cargo/bin" )
$env.PATH = ( $env.PATH | append "$env.HOME/.local/share/gem/ruby/3.4.0/bin" )
$env.PATH = ( $env.PATH | append "$env.HOME/.local/bin" )

$env.BAT_THEME         = "Catppuccin Mocha"
$env.EDITOR            = "$env.HOME/.local/share/bob/nvim-bin/nvim"
$env.PLAYDATE_SDK_PATH = "$env.HOME/Documents/PlaydateSDK-3.0.2"

$env.HOMEBREW_NO_ENV_HINTS = 1

/home/linuxbrew/.linuxbrew/bin/recall list
/home/linuxbrew/.linuxbrew/bin/fastcards amount
/home/linuxbrew/.linuxbrew/bin/hocusfocus currentsession
/home/linuxbrew/.linuxbrew/bin/termfarm stats
open ~/.scripts/motds.txt | lines | shuffle | first | $"󰆈 ($in)"

$env.FZF_DEFAULT_OPTS = "
		--tmux
		--preview 'bat --color=always {}'
		--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
		--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
		--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
		--color=selected-bg:#45475A
		--color=border:#6C7086,label:#CDD6F4"

alias yz = yazi
alias cd = z
