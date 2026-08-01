typeset -g ANTIDOTE_HOME="$XDG_CACHE_HOME/antidote"
typeset -g _dotfiles_plugin_bundle="$XDG_CACHE_HOME/zsh/plugins.zsh"

if [[ -r "$_dotfiles_plugin_bundle" ]]; then
  source "$_dotfiles_plugin_bundle"
else
  # A fresh clone remains usable before explicit plugin preparation.
  bindkey -v
  _dotfiles_apply_bindings
  _dotfiles_fzf_init
fi

if [[ -r "$XDG_CACHE_HOME/zsh/zoxide.zsh" ]]; then
  source "$XDG_CACHE_HOME/zsh/zoxide.zsh"
elif (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

if [[ -r "$XDG_CACHE_HOME/zsh/ls-colors.zsh" ]]; then
  source "$XDG_CACHE_HOME/zsh/ls-colors.zsh"
elif (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate vesper 2>/dev/null)"
fi

unset _dotfiles_plugin_bundle
