# Small, explicit shortcuts. Core commands retain their original behavior.
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'

(( $+commands[nvim] )) && alias v='nvim'
(( $+commands[git] )) && alias g='git'

if (( $+commands[eza] )); then
  alias l='eza --icons=auto --group-directories-first'
  alias ll='eza --icons=auto --group-directories-first --long --git'
  alias la='eza --icons=auto --group-directories-first --long --git --all'
  alias lt='eza --icons=auto --group-directories-first --tree --level=2'
fi
