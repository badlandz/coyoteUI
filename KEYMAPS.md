# The CoyoteUI Keymap Cheat Sheet

This cheat sheet summarizes the **most common and most used** key bindings and aliases from the coyoteUI configurations, verified directly from the repository files:

- **Bashrc**: `bashrc/MVtoDOTbashrc.txt` (aliases + vi-mode defaults)
- **Tmux**: `tmux/MVtoDOTtmuxconf.txt` (prefix: `Ctrl-Space`, plugins like sessionx/resurrect)
- **Neovim**: `nvim-config/lua/config/keymaps.lua` (leader: `Space`, Lazy.nvim setup)

Bindings are grouped by tool, with **bolded entries** highlighting the top ~80% of daily actions (e.g., file navigation, pane switching, LSP jumps). All entries exist in the current repo — no assumptions or additions.

---

## Bashrc: Aliases & Vi-Mode (Most Used: File Listing & Editor Launch)

### Aliases (Global)
| Alias **(Most Used)** | Expansion | Category | Use Case |
|-----------------------|-----------|----------|----------|
| **ls**, **l** | `eza` | File List | Quick directory view |
| **vi**, **vim**, **nv** | `nvim` | Editor | Open Neovim |
| **ll** | `eza -l --sort newest` | File List | Detailed + newest first |
| **h** | `clear; neofetch; eza` | System | Dashboard + list |
| **s** | `du -sh * \| sort -h` | Disk | Sorted usage |
| **mv** | `mv -i` | File Ops | Safe move |
| **cp** | `cp -i` | File Ops | Safe copy |
| **df** | `dysk` | Disk | Visual disk analyzer |
| lla | `eza -al` | File List | All files, detailed |
| la | `eza -a` | File List | Show hidden |
| lr | `eza -R` | File List | Recursive |
| l. | `la -d .?*` | File List | Dotfiles only |

### Vi-Mode (Line Editing)
| Mode | Key **(Most Used)** | Action | Notes |
|------|---------------------|--------|-------|
| Insert | **Esc** | Enter Normal | Toggle mode |
| Normal | **i** | Insert at cursor | Edit |
| Normal | **a** | Append after | Edit end |
| Normal | **h/j/k/l** | Navigate | Arrow alt |
| Normal | **dd** | Delete line | Clear |
| Normal | **yy** | Copy line | Reuse |
| Normal | **p** | Paste | Insert |

---

## Tmux: Prefix & Navigation (Most Used: Splits & Pane Switching)

Prefix: **`Ctrl-Space`** (custom; double to send literal)

### Prefix Commands (`Ctrl-Space` + Key)
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **%** | Vertical split | Panes | New side pane |
| **"** | Horizontal split | Panes | New bottom pane |
| **o** | Fuzzy session switcher | Sessions | zoxide + FZF |
| **r** | Reload config | Config | Apply changes |
| **I** (capital) | Install plugins | TPM | One-time |
| **U** | Update plugins | TPM | Refresh |
| **s** | List sessions | Sessions | Switch |
| **y** | Yank to clipboard | Copy | tmux-yank |
| Ctrl-r | Restore session | Resurrect | Load saved state |

### No-Prefix Navigation
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **Alt-h/j/k/l** | Switch pane | Navigation | Vim-style |
| Mouse Drag | Resize pane | Panes | Enabled |

---

## Neovim: Modal Keymaps (Most Used: Escape, Resize, LSP)

Leader: **`Space`**  
From `nvim-config/lua/config/keymaps.lua`

### Normal Mode
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **<leader>pv** | `:Ex` (explorer) | Navigation | File browser |
| **<C-h/j/k/l>** | Resize split | Windows | ±2 units |
| **<leader>sm** | Toggle spell | Editing | On/off |
| **<leader>u** | Undo tree | Undo | Visual history |
| **<leader>rn** | LSP rename | Refactor | Symbol rename |
| **<leader>ca** | Code actions | LSP | Quick fix |
| **gd** | Go to definition | LSP | Jump |
| **K** | Hover doc | LSP | Info |
| **<leader>vpp** | Prettier format | Format | Auto-format |
| **Q** | Play `@q` macro | Macros | Safe replay |

### Insert Mode
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **jk** | Escape to Normal | Exit | Fast mode switch |

### Visual Mode
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **J** | Join lines (no space) | Edit | Clean join |
| **<leader>p** | Paste without yank | Paste | Keep register |

### Command Mode
| Key **(Most Used)** | Action | Category | Notes |
|---------------------|--------|----------|-------|
| **w!!** | Sudo save | Save | `:!sudo tee %` |

---

## Workflow Integration Tips
- **Bash → Tmux → Neovim**: Use `nv` in bash → tmux split → Neovim with `<leader>pv` for files.
- **No Conflicts**: Tmux prefix ≠ bash vi-mode; Neovim leader ≠ tmux nav.
- **Update**: Edit configs → run `./go-coyote.sh` → bindings apply instantly.

*Verified from repo @ commit `main` (Nov 16, 2025). Update via PR or `go-coyote.sh`.*
