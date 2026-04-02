#!/usr/bin/env bash
set -euo pipefail

# ====================
# Bootstrap script for macOS
# Installs tools, CLIs, and links dotfiles via GNU Stow
#
# Usage:
#   ./install.sh              Install everything
#   ./install.sh --no-mobile  Skip mobile tooling
#   ./install.sh --no-casks   Skip GUI apps (Ghostty, Stats, etc.)
#   ./install.sh --minimal    Only core CLI tools + dotfiles
# ====================

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$DOTFILES_DIR/.install.log"

# Defaults
INSTALL_MOBILE=true
INSTALL_CASKS=true
INSTALL_MINIMAL=false

for arg in "$@"; do
  case "$arg" in
    --no-mobile) INSTALL_MOBILE=false ;;
    --no-casks)   INSTALL_CASKS=false ;;
    --minimal)    INSTALL_MINIMAL=true; INSTALL_MOBILE=false; INSTALL_CASKS=false ;;
    --help|-h)
      echo "Usage: ./install.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --no-mobile   Skip mobile tooling (Java, SDKMAN, Maestro, CocoaPods, Expo, EAS)"
      echo "  --no-casks    Skip GUI apps (Ghostty, Stats)"
      echo "  --minimal     Only core CLI tools + dotfiles"
      echo "  --help        Show this help"
      exit 0
      ;;
    *) echo "Unknown option: $arg (try --help)"; exit 1 ;;
  esac
done

# ====================
# Colors (Catppuccin Mocha palette)
# ====================
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'
BLUE='\033[38;5;117m'    # sapphire
GREEN='\033[38;5;120m'   # green
YELLOW='\033[38;5;223m'  # yellow
RED='\033[38;5;210m'     # red
MAUVE='\033[38;5;183m'   # mauve
TEAL='\033[38;5;116m'    # teal
SURFACE='\033[38;5;243m' # surface1

# ====================
# UI helpers
# ====================
SPINNER_PID=""
CURRENT_STEP=0
TOTAL_STEPS=0
SECTION_START=""

cleanup() {
  spinner_stop
  tput cnorm 2>/dev/null || true  # restore cursor
}
trap cleanup EXIT

spinner_start() {
  local msg="$1"
  tput civis 2>/dev/null || true  # hide cursor
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

progress_bar() {
  local current=$1
  local total=$2
  local width=30
  local pct=$(( current * 100 / total ))
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))
  local bar=""
  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done
  printf "${SURFACE}[${TEAL}%s${SURFACE}]${RESET} ${DIM}%d%%${RESET}" "$bar" "$pct"
}

section() {
  local icon="$1"
  local title="$2"
  SECTION_START=$(date +%s)
  echo ""
  printf "  ${BOLD}%s %s${RESET}\n" "$icon" "$title"
  printf "  ${SURFACE}%s${RESET}\n" "──────────────────────────────────────"
}

section_done() {
  local elapsed=$(( $(date +%s) - SECTION_START ))
  if (( elapsed > 0 )); then
    printf "  ${TEAL}done in %ds${RESET}\n" "$elapsed"
  fi
}

ok() {
  printf "  ${GREEN}✓${RESET} %s\n" "$1"
}

skip() {
  printf "  ${SURFACE}○ %s${RESET}\n" "$1"
}

warn() {
  printf "  ${YELLOW}! %s${RESET}\n" "$1"
}

fail() {
  printf "  ${RED}✗ %s${RESET}\n" "$1"
}

# Run a command with spinner, log output (never crashes the script)
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

brew_install() {
  if brew list --formula "$1" &>/dev/null; then
    ok "$1"
  else
    run "Installing $1" brew install "$1"
  fi
}

cask_install() {
  if brew list --cask "$1" &>/dev/null; then
    ok "$1"
  elif brew install --cask "$1" >> "$LOG_FILE" 2>&1; then
    ok "$1"
  elif brew install --cask --force "$1" >> "$LOG_FILE" 2>&1; then
    ok "$1 (force-adopted)"
  else
    warn "$1 could not be installed, check log"
  fi
}

# ====================
# Header
# ====================
clear
printf "${MAUVE}"
cat << 'LOGO'

        ██████╗  ██████╗ ████████╗███████╗
        ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
        ██║  ██║██║   ██║   ██║   ███████╗
        ██║  ██║██║   ██║   ██║   ╚════██║
        ██████╔╝╚██████╔╝   ██║   ███████║
        ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
LOGO
printf "${RESET}"
printf "        ${DIM}──── macOS Bootstrap ────${RESET}\n"
echo ""

printf "  ${DIM}Flags:${RESET} "
if [[ "$INSTALL_MOBILE" == true ]]; then
  printf "${GREEN}mobile${RESET} "
else
  printf "${SURFACE}mobile${RESET} "
fi
if [[ "$INSTALL_CASKS" == true ]]; then
  printf "${GREEN}gui-apps${RESET} "
else
  printf "${SURFACE}gui-apps${RESET} "
fi
if [[ "$INSTALL_MINIMAL" == true ]]; then
  printf "${YELLOW}minimal${RESET} "
fi
echo ""
printf "  ${DIM}Log:${RESET}   ${SURFACE}%s${RESET}\n" "$LOG_FILE"
echo ""

: > "$LOG_FILE"

# ====================
# Xcode Command Line Tools
# ====================
section "🛠" "Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
  ok "Already installed"
else
  xcode-select --install
  printf "  ${YELLOW}Waiting for Xcode CLI tools installation...${RESET}\n"
  printf "  Press enter once complete."
  read -r
fi
section_done

# ====================
# Homebrew
# ====================
section "🍺" "Homebrew"
if command -v brew &>/dev/null; then
  ok "Already installed ($(brew --version | head -1))"
else
  run "Installing Homebrew" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi
section_done

# ====================
# Core CLI tools
# ====================
CORE_FORMULAS=(
  git stow neovim
  eza bat fd ripgrep fzf zoxide dust sd procs btop tldr git-delta lazygit
  go volta
  yazi ffmpegthumbnailer poppler imagemagick
)

section "⚡" "Core CLI Tools (${#CORE_FORMULAS[@]} packages)"
CURRENT_STEP=0
TOTAL_STEPS=${#CORE_FORMULAS[@]}
for formula in "${CORE_FORMULAS[@]}"; do
  CURRENT_STEP=$((CURRENT_STEP + 1))
  if brew list --formula "$formula" &>/dev/null; then
    printf "  ${GREEN}✓${RESET} %-18s %s\n" "$formula" "$(progress_bar $CURRENT_STEP $TOTAL_STEPS)"
  else
    spinner_start "Installing $formula"
    if brew install "$formula" >> "$LOG_FILE" 2>&1; then
      spinner_stop
      printf "  ${GREEN}✓${RESET} %-18s %s\n" "$formula" "$(progress_bar $CURRENT_STEP $TOTAL_STEPS)"
    else
      spinner_stop
      printf "  ${RED}✗${RESET} %-18s %s\n" "$formula" "$(progress_bar $CURRENT_STEP $TOTAL_STEPS)"
    fi
  fi
done
section_done

# ====================
# Fonts
# ====================
FONT_CASKS=(
  font-geist-mono-nerd-font
  font-hack-nerd-font
  font-jetbrains-mono-nerd-font
  font-symbols-only-nerd-font
)

section "🔤" "Nerd Fonts (${#FONT_CASKS[@]} fonts)"
for cask in "${FONT_CASKS[@]}"; do
  cask_install "$cask"
done
section_done

# ====================
# Rust
# ====================
section "🦀" "Rust"
if command -v rustc &>/dev/null; then
  ok "Already installed ($(rustc --version 2>/dev/null))"
else
  run "Installing Rust via rustup" bash -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'
fi
. "$HOME/.cargo/env" 2>/dev/null || true
section_done

# ====================
# Volta PATH
# ====================
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ====================
# Mobile dev (optional)
# ====================
if [[ "$INSTALL_MOBILE" == true ]]; then
  section "📱" "Mobile Development"

  brew_install watchman
  brew_install cocoapods
  cask_install zulu@17

  # SDKMAN
  if [[ ! -d "$HOME/.sdkman" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    run "Installing SDKMAN" bash -c 'curl -s "https://get.sdkman.io?rcupdate=false" | bash'
  else
    ok "SDKMAN"
  fi

  # Maestro
  if command -v maestro &>/dev/null; then
    ok "Maestro"
  else
    run "Installing Maestro" bash -c 'curl -fsSL "https://get.maestro.mobile.dev" | bash'
  fi

  # EAS CLI
  run "Installing EAS CLI" volta install eas-cli@latest

  section_done
else
  section "📱" "Mobile Development"
  skip "Skipped (--no-mobile)"
  section_done
fi

# ====================
# GUI apps (optional)
# ====================
if [[ "$INSTALL_CASKS" == true ]]; then
  section "🖥" "GUI Apps"
  cask_install ghostty
  cask_install stats
  section_done
else
  section "🖥" "GUI Apps"
  skip "Skipped (--no-casks)"
  section_done
fi

# ====================
# Volta packages
# ====================
if [[ "$INSTALL_MINIMAL" == false ]]; then
  section "📦" "Node Ecosystem (via Volta)"
  run "node (latest)" volta install node@latest
  run "bun (latest)" volta install bun@latest
  run "pnpm (latest)" volta install pnpm@latest
  run "yarn (latest)" volta install yarn@latest
  run "any-buddy (Claude companion)" volta install any-buddy@latest
  section_done
fi

# ====================
# Oh My Zsh + plugins + theme
# ====================
section "🐚" "Oh My Zsh + Plugins"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh"
else
  run "Installing Oh My Zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Catppuccin theme
if [[ -f "$ZSH_CUSTOM/themes/catppuccin.zsh-theme" ]]; then
  ok "Catppuccin theme"
else
  spinner_start "Installing Catppuccin theme"
  mkdir -p "$ZSH_CUSTOM/themes/catppuccin-flavors"
  curl -fsSL -o "$ZSH_CUSTOM/themes/catppuccin.zsh-theme" \
    "https://raw.githubusercontent.com/catppuccin/zsh/main/catppuccin.zsh-theme" >> "$LOG_FILE" 2>&1
  for flavor in mocha frappe latte macchiato; do
    curl -fsSL -o "$ZSH_CUSTOM/themes/catppuccin-flavors/catppuccin-${flavor}.zsh" \
      "https://raw.githubusercontent.com/catppuccin/zsh/main/catppuccin-flavors/catppuccin-${flavor}.zsh" >> "$LOG_FILE" 2>&1
  done
  spinner_stop
  ok "Catppuccin theme"
fi

# Plugins
if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  ok "zsh-autosuggestions"
else
  run "Installing zsh-autosuggestions" git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  ok "zsh-syntax-highlighting"
else
  run "Installing zsh-syntax-highlighting" git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

section_done

# ====================
# GitHub CLI
# ====================
section "🐙" "GitHub CLI"
brew_install gh
if gh auth status &>/dev/null 2>&1; then
  ok "Already authenticated"
else
  echo ""
  printf "  ${BLUE}Launching GitHub login...${RESET}\n"
  echo ""
  gh auth login
fi
section_done

# ====================
# Claude Code
# ====================
section "🤖" "Claude Code"
if command -v claude &>/dev/null; then
  ok "Already installed ($(claude --version 2>/dev/null))"
else
  run "Installing Claude Code" bash -c 'curl -fsSL https://claude.ai/install.sh | bash'
fi
if claude auth status &>/dev/null 2>&1; then
  ok "Already authenticated"
else
  echo ""
  printf "  ${BLUE}Launching Claude login...${RESET}\n"
  echo ""
  claude auth login || warn "Claude auth failed, run 'claude auth login' manually"
fi
section_done

# ====================
# Yazi Catppuccin flavor
# ====================
section "📂" "Yazi"
eval "$(brew shellenv)"
run "Catppuccin Mocha flavor" bash -c 'ya pkg add yazi-rs/flavors:catppuccin-mocha 2>/dev/null'
section_done

# ====================
# Dotfiles (GNU Stow)
# ====================
section "🔗" "Dotfiles (GNU Stow)"
cd "$DOTFILES_DIR"

PACKAGES=(zsh git bat yazi nvim claude)
if [[ "$INSTALL_CASKS" == true ]]; then
  PACKAGES+=(ghostty)
fi

for pkg in "${PACKAGES[@]}"; do
  if [[ -d "$pkg" ]]; then
    stow "$pkg" --target="$HOME" --restow 2>> "$LOG_FILE" || true
    ok "$pkg"
  else
    warn "$pkg not found, skipping"
  fi
done
section_done

# ====================
# Summary
# ====================
echo ""
printf "  ${SURFACE}══════════════════════════════════════${RESET}\n"
echo ""
printf "  ${GREEN}${BOLD}  Setup complete!${RESET}\n"
echo ""
printf "  ${SURFACE}══════════════════════════════════════${RESET}\n"
echo ""
printf "  ${DIM}Open a new terminal to apply all changes.${RESET}\n"
echo ""
printf "  ${BOLD}Remaining manual steps:${RESET}\n"
printf "  ${SURFACE}│${RESET} Open ${BOLD}nvim${RESET} — Mason installs LSPs automatically\n"
if [[ "$INSTALL_MOBILE" == true ]]; then
  printf "  ${SURFACE}│${RESET} Run  ${BOLD}sdk install java${RESET} — install Java via SDKMAN\n"
fi
printf "  ${SURFACE}│${RESET} Full log: ${DIM}%s${RESET}\n" "$LOG_FILE"
echo ""
