# coyoteUI: Unified CLI Development Environment

![coyoteUI Logo](https://img.shields.io/badge/coyoteUI-CLI%20IDE-blue?style=for-the-badge)

**coyoteUI** is a streamlined, transparent configuration manager for bash, tmux, and Neovim, designed to create a cohesive, high-productivity command-line interface (CLI) from the moment you log in. It eliminates scattered dotfiles, hidden repositories, and configuration drift by centralizing all setups in a single Git repository at `~/src/coyoteUI/`. With one script—`go-coyote.sh`—you install, update, and deploy your entire development environment across systems.

---

## Project Goals

1. **Single Source of Truth**: All configurations live in `~/src/coyoteUI/` — no more hunting through `~/.bashrc`, `~/.tmux.conf`, or `~/.config/nvim/`.
2. **Maximum Transparency**: Files are in default locations after deployment, but editable and versioned in the project directory.
3. **Idempotent Deployment**: Run `go-coyote.sh` anytime — it captures baselines, pulls upstreams, rebuilds Neovim, and applies changes safely.
4. **Git-Powered Efficiency**: Submodules for external sources (e.g., Neovim), automatic commits for baselines, and easy syncing via GitHub.
5. **Zero-Friction Login**: From shell login → tmux session → Neovim IDE — a seamless, distraction-free workflow.

---

## Inspiration & Credits

This project draws heavily from two key YouTube videos that redefined CLI UX:

- **[A UX Expert Fixes My Tmux.conf](https://youtu.be/_hnuEdrM-a0)**  
  *by ThePrimeagen & UX Expert*  
  → Inspired the **top status bar**, **subtle Catppuccin theme**, **dynamic alerts**, **fuzzy session switching (t-switch → sessionx)**, and **ergonomic prefix (`Ctrl-Space`)**. The goal: reduce cognitive load and make tmux *proactive*, not reactive.

- **Neovim as a Full IDE (Lua Config Series)**  
  *by @tjdevries, @nanotee, and the Lazy.nvim community*  
  → Shaped the modular `lua/config/` structure, LSP-first keymaps, and plugin management via `lazy.lua`.

Additional tools and credits:
- `eza`, `bat`, `dysk`, `starship`, `zoxide` — modern CLI replacements
- `tmux-plugin-manager (TPM)` — for sessionx, resurrect, yank
- `Lazy.nvim` — plugin and config loader
- `Catppuccin/tmux` — pastel, eye-friendly theme

---

## Core Philosophy: Resolve Keymap Conflicts First

coyoteUI **prioritizes navigation harmony** across tools:

| Layer | Navigation | Binding |
|-------|------------|---------|
| Bash | Vi-mode readline | `h/j/k/l`, `Esc` |
| Tmux | Pane switching | `Alt-h/j/k/l` (no prefix) |
| Neovim | Window resize | `<C-h/j/k/l>` |
| Neovim | Pane-like nav | Consistent with tmux |

**Result**: Muscle memory transfers seamlessly — `Alt-h/j/k/l` moves you in tmux, `<C-h/j/k/l>` resizes in Neovim, and `h/j/k/l` edits commands in bash. No mode confusion, no prefix overload.

---

## The Vision: A Full NeoVIM IDE in Tmux

coyoteUI is the foundation for a **terminal-native IDE**:

### Phase 1 (Current)
- Unified config deployment
- Keymap conflict resolution
- Fuzzy project switching (`sessionx + zoxide`)
- Session persistence (`resurrect + continuum`)

### Phase 2 (Next)
- **Dynamic tmux scripts**:
  - Auto-detect git root → open in Neovim
  - Meeting alerts in status bar (`#(~/bin/meeting-alert.sh)`)
  - Battery, CPU, network widgets
- **Neovim IDE enhancements**:
  - File tree (neo-tree)
  - Terminal splitter (toggleterm)
  - Git integration (gitsigns, fugitive)
  - Debugger UI (nvim-dap)

### Phase 3 (Future)
- **Login → IDE in 3 seconds**:
  ```bash
  # .bash_profile or .zprofile
  if [ -z "$TMUX" ] && [ "$SSH_CONNECTION" = "" ]; then
    exec tmux new-session -A -s main
  fi
- → Login → tmux → Neovim split with project → code.

# Project Structure
```
~/src/coyoteUI/
├── go-coyote.sh          # Install/update script
├── bashrc/               # MVtoDOTbashrc.txt
├── tmux/                 # MVtoDOTtmuxconf.txt + scripts
├── nvim-config/          # init.lua, lua/config/, lua/plugins/
├── neovim-src/           # (optional) submodule for building
├── log/                  # Timestamped install logs
├── KEYMAPS.md            # Keymap cheat sheet
└── README.md             # You're here
```

# Quickstart Guide

## Clone and deploy

```
git clone https://github.com/badlandz/coyoteUI.git ~/src/ 
git clone https://github.com/badlandz/coyoteUI.git ~/src/ 
coyoteUI
cd ~/src/coyoteUI
./go-coyote.sh

# Edit, tweak, redeploy
nvim nvim-config/lua/config/keymaps.lua
./go-coyote.sh  # Applies instantly
```

