
alias egrep='egrep -G'
alias fgrep='fgrep -G'
alias grep='grep -G'
alias l.='ls -d .* -G'
alias ll='ls -l -G'
alias ls='ls -G'
alias vi='vim'

# alias for git
alias ga='git add'
alias gs='git status'
alias gd='git diff'

export LSCOLORS='gxfxcxdxbxegedabagacad'

ZSH_THEME="robbyrussell"

# You need to mkdir -p ~/.zsh && cd ~/.zsh
# Download the two script in ~/.zsh dir
#
# curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
# curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
export GOPATH=/Users/dsh/gopath

alias tags='ctags -R -f .tags && cscope -Rbkq -f .cscope.out && touch .ctrlp'
