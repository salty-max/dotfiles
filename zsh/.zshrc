# ====================
# Oh My Zsh
# ====================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha"
CATPPUCCIN_SHOW_TIME=true
plugins=(
  git                        # git aliases (gst, gco, gp, etc.)
  zoxide                     # z command (smart cd)
  fzf                        # Ctrl+R history, Ctrl+T file picker
  volta                      # node version completions
  docker                     # docker completions & aliases
  extract                    # extract any archive with `x`
  sudo                       # double ESC to prepend sudo
  copypath                   # copy current path with `copypath`
  copyfile                   # copy file content with `copyfile`
  web-search                 # `google "query"` from terminal
  zsh-interactive-cd         # tab-complete cd with fzf
  command-not-found          # suggest install when command missing
  zsh-autosuggestions        # fish-like suggestions as you type (custom)
  zsh-syntax-highlighting    # highlights valid/invalid commands (custom, must be last)
)
source "$ZSH/oh-my-zsh.sh"

# ====================
# Shell integrations
# ====================
eval "$(zoxide init zsh)"
source <(fzf --zsh 2>/dev/null) || true

# ====================
# Environment
# ====================
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export VOLTA_HOME="$HOME/.volta"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"

# ====================
# PATH
# ====================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.maestro/bin:$PATH"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ====================
# Modern CLI aliases
# ====================
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias cat='bat --paging=never'
alias du='dust'
alias ps='procs'
alias top='btop'

# ====================
# Dotfiles management
# ====================
alias dotinstall='bash "$HOME/.dotfiles/install.sh"'
alias dotupdate='bash "$HOME/.dotfiles/update.sh"'

# ====================
# Git aliases (supplements oh-my-zsh git plugin)
# ====================
alias gpfl='git push --force-with-lease'

# ====================
# Functions
# ====================

# Assign current PR to me, add reviewer, request Claude review
# Usage: prr <reviewer>
prr() {
  local pr=$(gh pr view --json number --jq '.number' 2>/dev/null)
  if [[ -z "$pr" ]]; then echo "No PR found for current branch"; return 1; fi
  echo "Assigning PR #$pr to me, adding $1 as reviewer..."
  gh pr edit "$pr" --add-assignee @me --add-reviewer "$1"
  echo "Requesting Claude review..."
  gh pr comment "$pr" --body "@claude review"
  echo "Done!"
}

# mkdir + cd in one command
take() { mkdir -p "$1" && cd "$1"; }

# ====================
# Completions
# ====================
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ====================
# Plugins (claude-mem worker)
# ====================
alias claude-mem='bun "$HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# ====================
# SDKMAN (must be last)
# ====================
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
