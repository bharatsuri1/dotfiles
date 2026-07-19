#!/usr/bin/env bash
# Claude Code statusLine — Rose Pine themed, two-line layout
set -euo pipefail

input=$(cat)

# Extract values
MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
# DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Rose Pine Moon palette (ANSI-C quoting for real escape bytes)
iris=$'\033[38;2;196;167;231m'      # #c4a7e7 — accents, model name
# rosewater=$'\033[38;2;245;224;220m' # #f5e0dc — directory name
foam=$'\033[38;2;156;207;216m'      # #9ccfd8 — low context (< 60%)
gold=$'\033[38;2;234;154;151m'      # #ea9a97 — medium context (60-80%), cost
love=$'\033[38;2;235;111;146m'      # #eb6f92 — high context (> 80%)
subtle=$'\033[38;2;110;106;134m'    # #6e6a86 — separators, muted text
text=$'\033[38;2;224;222;244m'      # #e0def4 — general text
reset=$'\033[0m'

# ── Progress bar ──────────────────────────────────────────────
if [ "$PCT" -ge 80 ]; then BAR_COLOR="$love"
elif [ "$PCT" -ge 60 ]; then BAR_COLOR="$gold"
else BAR_COLOR="$foam"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

# ── Duration ──────────────────────────────────────────────────
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

# ── Git branch + dirty flag ───────────────────────────────────
# BRANCH=""
# if git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
#     BRANCH_NAME=$(git -C "$DIR" branch --show-current 2>/dev/null || echo "")
#     if [ -n "$BRANCH_NAME" ]; then
#         DIRTY=""
#         if ! git -C "$DIR" diff-index --quiet HEAD -- 2>/dev/null; then
#             DIRTY=" ${gold}✱${reset}"
#         fi
#         BRANCH=" ${subtle}|${reset} ${iris} ${BRANCH_NAME}${reset}${DIRTY}"
#     fi
# fi

# ── Cost ──────────────────────────────────────────────────────
COST_FMT=$(printf ' %.2f' "$COST")

# echo "${iris}[${MODEL}]${reset} ${subtle}|${reset} ${rosewater}  ${DIR##*/}${reset}${BRANCH}"
echo "${iris}[${MODEL}]${reset} ${subtle}| ${BAR_COLOR}${BAR}${reset} ${text}${PCT} 󰏰 ${reset} ${subtle}|${reset} ${gold}${COST_FMT}${reset} ${subtle}|${reset}   ${text}${MINS}m ${SECS}s${reset}"
