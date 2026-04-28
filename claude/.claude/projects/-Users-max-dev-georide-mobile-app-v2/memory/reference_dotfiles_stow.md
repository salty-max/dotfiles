---
name: Dotfiles managed with GNU Stow
description: User's dotfiles are in ~/.dotfiles repo, symlinked via stow — commit config changes there, not in ~/.config
type: reference
---

Dotfiles repo is at `~/.dotfiles`, managed with GNU Stow. Each tool has its own directory (nvim, zsh, ghostty, etc.) mirroring the home directory structure.

**How to apply:** When committing config file changes (nvim, git, zsh, etc.), always commit in `~/.dotfiles`, never in `~/.config` directly.
