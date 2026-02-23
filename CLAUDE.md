# CLAUDE.md

GNU Stow-based dotfiles for macOS and Linux. Each app gets its own directory with configs that symlink to `$HOME`.

## Quick Reference

- **Deploy config**: `stow <app-name>`
- **Remove config**: `stow -D <app-name>`
- **After creating new scripts**: run `stow <app>` to symlink them into `$PATH`

Stow is configured via `.stowrc` to target `$HOME`, enable dotfiles mode (`dot-` → `.`), and ignore `.DS_Store`.

## Structure

```
<app>/
  dot-config/<app>/       # XDG configs (~/.config/<app>/)
  dot-local/bin/           # Scripts (~/.local/bin/)
  dot-local/share/         # Data files (~/.local/share/)
```

- `dot-` prefix becomes `.` after stow deployment
- Platform-specific overrides use `<app>-darwin/` and `<app>-linux/` directories (e.g., `ghostty-darwin/`, `kitty-linux/`) — stow the right one per OS
- Plans and design docs go in `.notes/plans/`

## App Categories

| Category  | Apps                                |
| --------- | ----------------------------------- |
| Shell     | zsh, starship, direnv               |
| Terminals | ghostty, kitty                      |
| Editor    | helix, zed                          |
| Git       | git (delta), gitui, lazygit, tig    |
| Tmux      | tmux, sesh                          |
| Files     | yazi, ncdu                          |
| Utils     | bat, btop, cheat, yamlfmt           |
| Packages  | homebrew (Brewfile)                 |
| Other     | pip, plasma, fonts, extras (vimium) |

## Shell Script Conventions

Every bash script follows this template:

```bash
#!/usr/bin/env bash
#
# Short description of what the script does.
#
# Additional context if needed (behavior, usage, etc).
#
# Set options:
#   e: Stop script if command fails
#   u: Stop script if unset variable is referenced
#   x: Debug, print commands as they are executed
#   f: Disable file name generation (globbing).
#   o pipefail: If any command in a pipeline fails it all fails
#
set -ufo pipefail
```

Rules:

- **Always include the full set options block** (e/u/x/f/pipefail) even when not all are active — it's a quick lookup reference
- **Every script gets a description block** between the shebang and set options

## Color Palette

Nord-deep theme across all tools. See @docs/nord-deep.md for the full palette.
