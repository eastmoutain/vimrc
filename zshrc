
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export LSCOLORS='gxfxcxdxbxegedabagacad'

unsetopt share_history

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

# dirdiff
function dirdiff()
{
    # Shell-escape each path:
    DIR1=$(printf '%q' "$1"); shift
    DIR2=$(printf '%q' "$1"); shift
    vim $@ -c "DirDiff $DIR1 $DIR2"
}

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

# disable git prompt in zsh
# git config --global oh-my-zsh.hide-info 1

