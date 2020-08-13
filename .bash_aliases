#alias tags='ctags -R -f .tags && cscope -Rbkq -f .cscope.out && touch .'

alias gtags='find . -name "*.go" -o -name "*.c" -o -name "*.h" \
             -o -name "*.cc" -o -name "*.hh" > cscope.files && cscope -b -k -f .cscope.out && \
             rm -rf cscope.files && \
             ctags -R -f .tags && \
             touch .ctrlp'

alias ga='git add'
alias gd='git diff'
alias gs='git status'

alias findx='find . -name '
