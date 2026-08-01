# Interactive shell orchestration. Modules own the implementation details.
[[ -o interactive ]] || return
[[ "$TERM" == dumb ]] && return

mkdir -p "$XDG_CACHE_HOME/zsh" "$XDG_STATE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt SHARE_HISTORY

fpath=("$ZDOTDIR/completions" $fpath)
autoload -Uz compinit
if [[ -s "$XDG_CACHE_HOME/zsh/zcompdump" ]]; then
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
else
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/bindings.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/prompt.zsh"

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
