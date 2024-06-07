# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
$ brew install git
```

### Stow

```
$ brew install stow
```

### Neovim

```
$ brew install nvim
```

### Tmux

```
$ brew install tmux
```

## Optional

### Alacritty

```
$ brew install alacritty
```

## Installation

First, check out the dotfiles repo in your `$HOME` directory using git

```
$ git clone git@github.com/salty-max/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

## Tmux Plugins Manager

In order to use the tmux config, you need to clone the plugin manager

```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

Then run tmux

```
$ tmux
```

and press `C-Space` + `I` to install plugins
