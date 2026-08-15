# Neovim

This repository contains my personal Neovim configuration.
It provides a focused editing environment with file navigation, fuzzy search, Git integration, Treesitter highlighting, LSP support, completion, and Markdown rendering.

## Requirements

- Linux
- Neovim 0.12 or later
- Git
- `pyright` and `ruff` for Python language support

This configuration is tested with Neovim 0.12.4 on Linux.

## Installation

Back up an existing Neovim configuration, if you have one:

```sh
mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
```

Clone the repository into the default Neovim configuration directory:

```sh
git clone https://github.com/imamnurby/dotfiles-nvim.git "$HOME/.config/nvim"
```

Start Neovim:

```sh
nvim
```

Neovim installs the configured plugins and Treesitter parsers when required.

## Custom settings

The leader key is `Space`.

| Binding | Action |
| --- | --- |
| `gy` | Copy text to the system clipboard |
| `gp` | Paste text from the system clipboard |
| `s` | Jump to a visible location with Flash |
| `S` | Select a Treesitter node with Flash |
| `Leader` then `e` | Toggle the file explorer sidebar |
| `Leader` then `fm` | Open or close Mini Files |
| `Leader` then `?` | Search file history |
| `Leader` then `Space` | Search open buffers |
| `Leader` then `ff` | Search files |
| `Leader` then `fg` | Search text in the project |
| `Leader` then `fd` | Search diagnostics |
| `Leader` then `fs` | Search lines in the current buffer |
| `Leader` then `bc` | Close the current buffer and preserve the window layout |
| `Leader` then `hp` | Preview the current Git hunk |
| `Leader` then `hb` | Show blame information for the current line |
| `Leader` then `hr` | Reset the current Git hunk |
| `Leader` then `hs` | Stage the current Git hunk |
| `K` | Show LSP hover information |
| `gd` | Go to an LSP definition |
| `grd` | Go to an LSP declaration |
| `gq` | Format through the active LSP server |

The LSP bindings are available when a language server attaches to the current buffer.

## Plugins

The configuration uses Neovim's built-in package manager and locks plugin revisions in `nvim-pack-lock.json`.

- Tokyo Night for the color scheme
- Mini.nvim for files, fuzzy finding, completion, snippets, notifications, statusline, icons, and surround actions
- Neo-tree for the file explorer sidebar
- Treesitter for syntax highlighting
- nvim-lspconfig for language server configurations
- Gitsigns for Git information and hunk actions
- Flash for navigation and Treesitter selection
- Which-key for key binding discovery
- render-markdown.nvim for Markdown rendering

## License

This configuration is available under the [MIT License](LICENSE).
