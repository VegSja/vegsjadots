# Dotfiles 💻✨

Personal dotfiles and configurations for macOS using Nix, Homebrew, GNU Stow, and Fish shell.

---

## Overview 📝

This repository contains my configuration files for various tools and applications.
Most software is managed via Nix, and settings are symlinked using GNU Stow.

## Prerequisites ✅

Before installing the dotfiles, ensure the following tools are installed:
 • Homebrew 🍺 — The macOS package manager
 • GNU Stow 📦 — For managing symlinks of configuration files
 • Nix ❄️ — For declarative package management and system configuration
 • Fish shell 🐟 — The shell used in this setup

## Installation Instructions 🚀

1. Install Homebrew 🍺

If you don’t have Homebrew installed, run:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install GNU Stow 📦

Install GNU Stow via Homebrew:

```sh
brew install stow
```

3. Install Nix ❄️

Install Nix by running:

```sh
curl \
  --proto '=https' \
  --tlsv1.2 \
  -sSf \
  -L https://install.determinate.systems/nix \
  | sh -s -- install
```

Please be prepared to answer with “no” when the determinate installer asks if you want to install Determinate Nix. As of today, Determinate Nix does not work well in combination with nix-darwin

4. Clone this repository 📂

Clone your dotfiles repo into your home directory:

```sh
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

5. Use GNU Stow to symlink configuration files 🔗

Run stow for the config folders you want to link. For example:

```sh
stow .config
stow .tmux.conf
```

This will create symlinks in your home directory for all managed configs.

6. Update your Nix system configuration:

```sh
darwin-rebuild switch --flake ~/.config/nix#air
```

## Usage

After installation, you can rebuild your nix config with:

```sh
nixupdate
```
