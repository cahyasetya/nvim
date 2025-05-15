# Improved Neovim Configuration

This configuration enhances your Neovim setup with several useful features while preserving your beautiful transparent terminal aesthetic. The improvements focus on developer productivity and visual feedback without cluttering the interface.

## New Features

### 1. Enhanced Indent Guides
- Added subtle vertical indent guides that work with your transparency settings
- Special highlighting for scope blocks (functions, conditionals, etc.)
- Automatically disabled in file explorers, help windows, etc.

### 2. Advanced Git Integration
- Improved Neogit configuration optimized for your transparent setup
- Added GitSigns with blame information on the current line
- Rich set of Git operations via keybindings

### 3. Function Signature Help
- Shows function signatures when typing function calls
- Highlights the current parameter you're working on
- Floating windows that stay above the cursor line

### 4. Code Navigation Scrollbar
- Added a scrollbar on the right side showing code structure
- Visual indicators for Git changes, search results, and diagnostics
- Makes it easier to navigate large files

## Key Bindings

### Git Operations
- `<leader>gs` - Open Neogit status panel
- `<leader>ghb` - Show Git blame for current line
- `<leader>ghtb` - Toggle Git blame for all lines
- `<leader>ghs` - Stage current hunk
- `<leader>ghr` - Reset current hunk
- `<leader>ghp` - Preview current hunk changes

### Navigation
- `]c` - Jump to next Git change
- `[c` - Jump to previous Git change

### UI Controls
- `<leader>tt` - Toggle transparency

## Customization Tips

1. **Adjust Transparency:**
   - Use `:ToggleTransparency` to switch between transparent and solid background
   - Edit transparency blend values in `/lua/config/transparency.lua`

2. **Change Indent Guide Style:**
   - Modify indent guide characters in `/lua/plugins/indent-guides.lua`
   - Adjust colors in the transparency settings

3. **Configure Git Blame:**
   - Customize blame format in `/lua/plugins/git.lua` under `current_line_blame_formatter`
   - Adjust delay by changing `delay` value in milliseconds

4. **Scrollbar Appearance:**
   - Edit scrollbar characters and colors in `/lua/plugins/scrollbar.lua`
   - Adjust blend values for subtle or more prominent display

## How These Improvements Work Together

This configuration is designed to maintain your clean, distraction-free coding environment while adding useful information that appears only when needed. All new features respect your transparency settings and work with your terminal background.

The improvements focus on providing contextual information (git changes, code structure, function signatures) without permanent screen real estate usage.
