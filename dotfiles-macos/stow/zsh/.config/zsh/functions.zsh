# Create a directory and enter it. Fails without changing directory if mkdir fails.
mkcd() {
  [[ "$#" -eq 1 ]] || { print -u2 'usage: mkcd DIRECTORY'; return 2; }
  mkdir -p -- "$1" && builtin cd -- "$1"
}

# Move to the root of the current Git worktree.
groot() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || return
  builtin cd -- "$root"
}
