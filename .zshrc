
alias egrep='egrep -G'
alias fgrep='fgrep -G'
alias grep='grep -G'
alias l.='ls -d .* -G'
alias ll='ls -l -G'
alias ls='ls -G'
alias vi='vim'

export LSCOLORS='gxfxcxdxbxegedabagacad'

ZSH_THEME="robbyrussell"

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
export GOPATH=/Users/dsh/gopath

alias tags='ctags -R -f .tags && cscope -Rbkq -f .cscope.out && touch .ctrlp'
