#!/usr/bin/env bash
mode="$1"
dir="$2"
cmd=$(gum choose "claude" "pi") || exit 0

# Launch via an interactive zsh so ~/.zshrc is sourced (picks up PATH and
# any env vars needed by the chosen tool).
launch_cmd="exec zsh -ic 'exec $cmd'"

case "$mode" in
  hsplit) tmux split-window -h -c "$dir" "$launch_cmd" ;;
  vsplit) tmux split-window -v -c "$dir" "$launch_cmd" ;;
  window) tmux new-window -c "$dir" "$launch_cmd" ;;
esac
