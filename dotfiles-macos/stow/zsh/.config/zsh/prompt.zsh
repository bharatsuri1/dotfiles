if [[ -r "$XDG_CACHE_HOME/zsh/starship.zsh" ]]; then
  source "$XDG_CACHE_HOME/zsh/starship.zsh"
elif (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  PROMPT='%F{yellow}%1~%f %# '
fi
