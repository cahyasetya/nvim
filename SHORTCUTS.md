# Neovim Keyboard Shortcuts

This document provides a comprehensive list of keyboard shortcuts available in this Neovim configuration.

## Navigation

### Window Navigation
- `<C-h>` - Move to the left window
- `<C-j>` - Move to the lower window
- `<C-k>` - Move to the upper window
- `<C-l>` - Move to the right window

### File Navigation (Telescope)
- `<leader>ff` - Find files
- `<leader>fg` - Find text (grep)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Search help tags
- `<leader>fr` - Recent files
- `<leader>fc` - Browse colorschemes
- `<leader>fs` - Document symbols

### Harpoon (Quick File Navigation)
- `<leader>a` - Add current file to Harpoon
- `<leader>h` - Toggle Harpoon quick menu
- `<leader>1` - Jump to Harpoon file 1
- `<leader>2` - Jump to Harpoon file 2
- `<leader>3` - Jump to Harpoon file 3
- `<leader>4` - Jump to Harpoon file 4

### Search Enhancement (Flash)
- `s` - Flash search (normal, visual, operator mode)
- `S` - Flash treesitter (normal, visual, operator mode)
- `r` - Remote flash (operator mode)
- `R` - Treesitter search (operator and visual mode)
- `<C-s>` - Toggle flash search (in command mode)

## Coding

### LSP
- `<C-A-a>` - Code actions
- `gs` - Document symbols (list functions in current file)
- `gd` - Go to definition
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Show hover documentation
- `<leader>cr` - Rename symbol
- `<leader>ca` - Code actions

### Completion (nvim-cmp)
- `<C-n>` - Select next item
- `<C-p>` - Select previous item
- `<C-b>` - Scroll docs backward
- `<C-f>` - Scroll docs forward
- `<C-Space>` - Open completion menu
- `<C-e>` - Close completion menu
- `<CR>` - Confirm selection
- `<S-CR>` - Replace with selection

### Snippets (LuaSnip)
- `<Tab>` - Jump forward in snippet
- `<S-Tab>` - Jump backward in snippet

### Search and Replace
- `<leader>sr` - Search and replace in files (Spectre)

## Terminal

### Terminal Toggle
- `<leader>t` - Toggle floating terminal
- `<leader>tv` - Toggle vertical terminal
- `<leader>th` - Toggle horizontal terminal

### Terminal Navigation
- `<C-h>` - Move to left window (in terminal mode)
- `<C-j>` - Move to lower window (in terminal mode)
- `<C-k>` - Move to upper window (in terminal mode)
- `<C-l>` - Move to right window (in terminal mode)
- `<Esc>` - Exit terminal mode

## UI

### Appearance
- `<leader>ut` - Toggle transparency

### File Explorer
- `<leader>e` - Toggle file explorer (Neo-tree)

## Git
- `<leader>gg` - Open Lazygit
- `<leader>gj` - Next hunk
- `<leader>gk` - Previous hunk
- `<leader>gl` - Blame line
- `<leader>gp` - Preview hunk
- `<leader>gr` - Reset hunk
- `<leader>gR` - Reset buffer
- `<leader>gs` - Stage hunk
- `<leader>gu` - Undo stage hunk

## Basic Vim

### Saving and Quitting
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>wq` - Save and quit

### Splits
- `<leader>-` - Split window horizontally 
- `<leader>|` - Split window vertically

## Other
- `<leader>uc` - Toggle colorscheme selector