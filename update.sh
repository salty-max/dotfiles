#!/usr/bin/env bash
set -euo pipefail

# ====================
# Update script for macOS
# Updates all tools, CLIs, and plugins
#
# Usage:
#   ./update.sh          Update everything
#   ./update.sh --quick  Skip slow updates (brew upgrade, rust)
# ====================

LOG_FILE="$(cd "$(dirname "$0")" && pwd)/.update.log"
QUICK=false

for arg in "$@"; do
  case "$arg" in
    --quick) QUICK=true ;;
    --help|-h)
      echo "Usage: ./update.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --quick  Skip slow updates (brew upgrade, rust)"
      echo "  --help   Show this help"
      exit 0
      ;;
    *) echo "Unknown option: $arg (try --help)"; exit 1 ;;
  esac
done

# ====================
# Colors (Catppuccin Mocha)
# ====================
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'
BLUE='\033[38;5;117m'
GREEN='\033[38;5;120m'
YELLOW='\033[38;5;223m'
RED='\033[38;5;210m'
MAUVE='\033[38;5;183m'
TEAL='\033[38;5;116m'
SURFACE='\033[38;5;243m'

# ====================
# UI helpers
# ====================
SPINNER_PID=""
SECTION_START=""
CURRENT_STEP=0
TOTAL_STEPS=0

cleanup() {
  spinner_stop
  tput cnorm 2>/dev/null || true
}
trap cleanup EXIT

spinner_start() {
  local msg="$1"
  tput civis 2>/dev/null || true
  (
    local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    while true; do
      printf "\r  ${MAUVE}%s${RESET} ${DIM}%s${RESET}  " "${frames[$i]}" "$msg"
      i=$(( (i + 1) % ${#frames[@]} ))
      sleep 0.08
    done
  ) &
  SPINNER_PID=$!
}

spinner_stop() {
  if [[ -n "${SPINNER_PID:-}" ]] && kill -0 "$SPINNER_PID" 2>/dev/null; then
    kill "$SPINNER_PID" 2>/dev/null
    wait "$SPINNER_PID" 2>/dev/null || true
    printf "\r\033[K"
  fi
  SPINNER_PID=""
  tput cnorm 2>/dev/null || true
}

section() {
  local icon="$1"
  local title="$2"
  SECTION_START=$(date +%s)
  echo ""
  printf "  ${BOLD}%s %s${RESET}\n" "$icon" "$title"
  printf "  ${SURFACE}──────────────────────────────────────${RESET}\n"
}

section_done() {
  local elapsed=$(( $(date +%s) - SECTION_START ))
  if (( elapsed > 0 )); then
    printf "  ${TEAL}done in %ds${RESET}\n" "$elapsed"
  fi
}

progress_bar() {
  local current=$1 total=$2 width=30
  local pct=$(( current * 100 / total ))
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))
  local bar=""
  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done
  printf "${SURFACE}[${TEAL}%s${SURFACE}]${RESET} ${DIM}%d%%${RESET}" "$bar" "$pct"
}

# run with progress bar (for batched sections)
run_p() {
  local label="$1"
  CURRENT_STEP=$((CURRENT_STEP + 1))
  shift
  spinner_start "$label"
  if "$@" >> "$LOG_FILE" 2>&1; then
    spinner_stop
    printf "  ${GREEN}✓${RESET} %-18s %s\n" "$label" "$(progress_bar $CURRENT_STEP $TOTAL_STEPS)"
  else
    spinner_stop
    printf "  ${RED}✗${RESET} %-18s %s\n" "$label" "$(progress_bar $CURRENT_STEP $TOTAL_STEPS)"
  fi
  return 0
}

ok()   { printf "  ${GREEN}✓${RESET} %s\n" "$1"; }
skip() { printf "  ${SURFACE}○ %s${RESET}\n" "$1"; }
warn() { printf "  ${YELLOW}! %s${RESET}\n" "$1"; }
fail() { printf "  ${RED}✗ %s${RESET}\n" "$1"; }
ver()  { printf "  ${DIM}→ %s${RESET}\n" "$1"; }

run() {
  local label="$1"
  shift
  spinner_start "$label"
  if "$@" >> "$LOG_FILE" 2>&1; then
    spinner_stop
    ok "$label"
  else
    spinner_stop
    fail "$label — check log"
  fi
  return 0
}

# ====================
# Header
# ====================
clear
printf "${TEAL}"
cat << 'LOGO'

        ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
        ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
        ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗
        ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝
        ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
         ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝
LOGO
printf "${RESET}"
printf "        ${DIM}──── macOS Update ────${RESET}\n"
echo ""

if [[ "$QUICK" == true ]]; then
  printf "  ${DIM}Mode:${RESET} ${YELLOW}quick${RESET} ${DIM}(skipping brew upgrade & rust)${RESET}\n"
fi
printf "  ${DIM}Log:${RESET}  ${SURFACE}%s${RESET}\n" "$LOG_FILE"
echo ""

: > "$LOG_FILE"

# ====================
# Homebrew
# ====================
if [[ "$QUICK" == false ]]; then
  section "🍺" "Homebrew (4 steps)"
  CURRENT_STEP=0; TOTAL_STEPS=4
  run_p "brew update" brew update
  run_p "brew upgrade" brew upgrade
  run_p "brew casks" brew upgrade --cask --greedy
  run_p "brew cleanup" brew cleanup
else
  section "🍺" "Homebrew"
  run "brew update" brew update
  skip "brew upgrade (--quick)"
fi
ver "Homebrew $(brew --version 2>/dev/null | head -1 | awk '{print $2}' || echo '?')"
section_done

# ====================
# Rust
# ====================
if command -v rustup &>/dev/null; then
  section "🦀" "Rust"
  . "$HOME/.cargo/env" 2>/dev/null || true
  if [[ "$QUICK" == false ]]; then
    run "rustup update" rustup update
  else
    skip "rustup update (--quick)"
  fi
  ver "Rust $(rustc --version 2>/dev/null | awk '{print $2}' || echo '?')"
  section_done
fi

# ====================
# Volta packages
# ====================
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

if command -v volta &>/dev/null; then
  VOLTA_PKGS=(node bun pnpm yarn any-buddy)
  if command -v eas &>/dev/null; then
    VOLTA_PKGS+=(eas-cli)
  fi
  section "📦" "Node Ecosystem (${#VOLTA_PKGS[@]} packages)"
  CURRENT_STEP=0; TOTAL_STEPS=${#VOLTA_PKGS[@]}
  for pkg in "${VOLTA_PKGS[@]}"; do
    run_p "$pkg" volta install "${pkg}@latest"
  done
  ver "Node $(node -v 2>/dev/null || echo '?') · Bun $(bun -v 2>/dev/null || echo '?') · pnpm $(pnpm -v 2>/dev/null || echo '?')"
  section_done
fi

# ====================
# Oh My Zsh
# ====================
section "🐚" "Oh My Zsh + Plugins (3 repos)"
CURRENT_STEP=0; TOTAL_STEPS=3
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  run_p "Oh My Zsh" bash -c 'cd "$HOME/.oh-my-zsh" && git pull'
else
  CURRENT_STEP=$((CURRENT_STEP + 1))
  skip "Oh My Zsh not installed"
fi

if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  run_p "autosuggestions" bash -c "cd '$ZSH_CUSTOM/plugins/zsh-autosuggestions' && git pull"
else
  CURRENT_STEP=$((CURRENT_STEP + 1))
  skip "zsh-autosuggestions not installed"
fi

if [[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  run_p "syntax-highlight" bash -c "cd '$ZSH_CUSTOM/plugins/zsh-syntax-highlighting' && git pull"
else
  CURRENT_STEP=$((CURRENT_STEP + 1))
  skip "zsh-syntax-highlighting not installed"
fi

section_done

# ====================
# Neovim
# ====================
section "📝" "Neovim (2 steps)"
CURRENT_STEP=0; TOTAL_STEPS=2
run_p "Lazy sync" nvim --headless "+Lazy! sync" +qa
run_p "Mason update" nvim --headless "+MasonUpdate" +qa
ver "Neovim $(nvim --version 2>/dev/null | head -1 | awk '{print $2}' || echo '?')"
section_done

# ====================
# Yazi
# ====================
if command -v ya &>/dev/null; then
  section "📂" "Yazi"
  run "Yazi packages" ya pkg upgrade
  section_done
fi

# ====================
# SDKMAN
# ====================
if [[ -d "$HOME/.sdkman" ]]; then
  section "☕" "SDKMAN"
  export SDKMAN_DIR="$HOME/.sdkman"
  run "SDKMAN self-update" bash -c 'source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk selfupdate'
  sdk_ver=$(bash -c 'source "$HOME/.sdkman/bin/sdkman-init.sh" 2>/dev/null && sdk version 2>/dev/null | grep -oE "[0-9]+\.[0-9]+\.[0-9]+"' 2>/dev/null || echo "unknown")
  ver "SDKMAN $sdk_ver"
  section_done
fi

# ====================
# Claude Code
# ====================
if command -v claude &>/dev/null; then
  section "🤖" "Claude Code"
  run "Claude Code" claude update
  ver "Claude Code $(claude --version 2>/dev/null || echo 'unknown')"
  section_done
fi

# ====================
# Summary
# ====================
echo ""
printf "  ${SURFACE}══════════════════════════════════════${RESET}\n"
echo ""
printf "  ${GREEN}${BOLD}  All up to date!${RESET}\n"
echo ""
printf "  ${SURFACE}══════════════════════════════════════${RESET}\n"
echo ""
printf "  ${DIM}Full log: %s${RESET}\n" "$LOG_FILE"
echo ""
