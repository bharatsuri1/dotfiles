export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/fzfrc"

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Atuin will eventually own Ctrl-R. Until then, keep Zsh history search there
# and let FZF own only file and directory selection.
export FZF_CTRL_R_COMMAND=

_dotfiles_fzf_init() {
  (( $+commands[fzf] )) || return
  [[ -o interactive && -t 0 && -t 1 ]] || return

  if [[ -r "$XDG_CACHE_HOME/zsh/fzf.zsh" ]]; then
    source "$XDG_CACHE_HOME/zsh/fzf.zsh"
  else
    source <(fzf --zsh)
  fi
}
