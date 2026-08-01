# zsh-vi-mode keeps its default lazy initialization. Its post-init hook restores
# bindings deterministically without adding the full plugin cost to shell startup.
# Native vi mode remains the offline fallback when no bundle has been prepared.
KEYTIMEOUT=4

zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_SYSTEM_CLIPBOARD_ENABLED=false
}

_dotfiles_apply_bindings() {
  autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

  bindkey -M viins '^R' history-incremental-search-backward
  bindkey -M viins '^[[A' up-line-or-beginning-search
  bindkey -M viins '^[[B' down-line-or-beginning-search
  bindkey -M viins '^A' beginning-of-line
  bindkey -M viins '^E' end-of-line
}

zvm_after_init() {
  _dotfiles_apply_bindings
  _dotfiles_fzf_init
}
