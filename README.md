# Organized Neovim Configuration for Ghostty

This Neovim configuration is specially crafted to work seamlessly with Ghostty terminal, providing an enhanced coding experience with beautiful aesthetics and optimal performance.

## Project Structure

The configuration is organized into logical categories:

```
.config/nvim/
├── init.lua                     # Main entry point
├── README.md                    # Documentation
├── lua/
│   ├── config/                  # Core configurations
│   │   ├── autocmds.lua         # Auto commands
│   │   ├── ghostty-welcome.lua  # Ghostty welcome screen
│   │   ├── keymaps.lua          # Key mappings
│   │   ├── lazy.lua             # Plugin manager setup
│   │   ├── options.lua          # Neovim options
│   │   ├── transparency.lua     # Transparency functionality
│   │   └── ui.lua               # UI settings
│   └── plugins/                 # Plugin configurations
│       ├── init.lua             # Plugin loader
│       ├── coding/              # Coding-related plugins
│       │   ├── init.lua         # Coding plugins index
│       │   ├── syntax.lua       # Syntax highlighting
│       │   └── ...
│       ├── editor/              # Editor functionality
│       │   ├── init.lua         # Editor plugins index
│       │   ├── performance.lua  # Performance optimizations
│       │   ├── terminal.lua     # Terminal integration
│       │   └── ...
│       ├── ghostty/             # Ghostty-specific plugins
│       │   ├── init.lua         # Ghostty plugins index
│       │   ├── integration.lua  # Ghostty integration
│       │   ├── optimizations.lua # Ghostty optimizations
│       │   └── transparency.lua # Ghostty transparency
│       ├── tools/               # Utility tools
│       │   └── ...
│       └── ui/                  # UI components
│           ├── init.lua         # UI plugins index
│           ├── colorscheme.lua  # Color themes
│           ├── cursor.lua       # Cursor enhancements
│           ├── dashboard.lua    # Welcome dashboard
│           ├── neo-tree.lua     # File explorer
│           ├── statusline.lua   # Status line
│           └── windows.lua      # Window appearance
```

## Key Features

### UI Enhancements
- **Beautiful Transparency**: Works with Ghostty's background blur
- **Tokyo Night Theme**: A dark, easy-on-the-eyes color scheme
- **Custom Status Line**: Shows mode, Git info, and Ghostty status
- **File Explorer**: Enhanced Neo-tree with icons and Git integration
- **Welcome Dashboard**: Custom start screen with helpful shortcuts

### Terminal Integration
- **Floating Terminal**: Open terminal windows with <leader>t
- **Split Terminals**: Open terminals in vertical/horizontal splits
- **Cursor Styles**: Different cursor shapes for different modes
- **Ghostty Detection**: Automatic optimization for Ghostty terminal

### Coding Features
- **Syntax Highlighting**: Enhanced with Treesitter
- **Rainbow Parentheses**: Easier code navigation
- **Git Integration**: Show changes directly in the editor
- **Indentation Guides**: Visual indentation markers

### Performance Optimizations
- **Startup Speed**: Optimized plugin loading
- **Ghostty-specific Tweaks**: Settings that work best with Ghostty
- **Lazy Loading**: Only load plugins when needed

## Key Commands

| Keybinding | Action |
|------------|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>t` | Open floating terminal |
| `<leader>tv` | Open vertical terminal split |
| `<leader>th` | Open horizontal terminal split |
| `<leader>ut` | Toggle transparency |
| `<leader>uc` | Toggle fancy cursor effects |
| `<C-\>` | Toggle terminal (alternative) |
| `<Esc>` | Exit terminal mode |

## Custom Commands

| Command | Description |
|---------|-------------|
| `:GhosttyWelcome` | Show Ghostty welcome screen |
| `:GhosttyOptions` | Show available Ghostty options |
| `:ToggleTransparency` | Toggle background transparency |
| `:ToggleFancyCursor` | Toggle cursor animation effects |

## Ghostty Integration

This configuration automatically detects when running in Ghostty terminal and applies optimizations:

1. **Background Transparency**: Works with Ghostty's blur effect
2. **Terminal Colors**: Consistent colors in both UI and terminal windows
3. **Performance Tweaks**: Settings optimized for Ghostty's renderer
4. **Cursor Styles**: Special cursor handling for Ghostty terminal

## Credits

Built on LazyVim with custom configurations for Ghostty terminal.
