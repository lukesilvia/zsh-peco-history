# zsh-peco-history
# Search shell history with peco when pressing ctrl+r.
# https://github.com/jimeh/zsh-peco-history
#
# Based on: https://github.com/mooz/percol#zsh-history-search
# Get peco from: https://github.com/peco/peco
#
if which peco &> /dev/null; then
  function peco_select_history() {
    if which tac >/dev/null; then
      BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    else
      BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    fi

    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
  }

  zle -N peco_select_history
  bindkey '^R' peco_select_history
fi
