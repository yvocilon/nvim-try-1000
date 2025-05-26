# nvim-starter-plus

A **lightweight Neovim starter** that feels like VS Code, tuned for:

* **Remix / React Native** (TypeScript (ts_ls), TSX, JSX)
* **Tailwind CSS
* **Autopairs** – automatic brackets/quotes insertion** (class‑name IntelliSense + color squares)
* **Floating lazygit** inside Neovim (ToggleTerm)
* Ghostty (24‑bit colors)

> Created on 2025-05-22

---

## Features

| Area | Included |
|------|----------|
| Core UX | Treesitter, Telescope, Neo‑tree, Bufferline, Lualine |
| Code Intelligence | LSP (`tsserver`, `eslint`, **`tailwindcss`**), `nvim‑cmp`, LuaSnip |
| Git | `gitsigns.nvim` + **floating lazygit** via ToggleTerm |
| Tailwind Goodies | `tailwindcss-colorizer-cmp.nvim` (color squares in completion) |
| Theme | Tokyo Night (works great in Ghostty) |
| Terminal | ToggleTerm for Metro / Expo or any shell command |

---

## Install

```bash
# 1. Unpack
unzip nvim-starter-plus.zip

# 2. Move/symlink
mv nvim-starter-plus ~/.config/nvim

# 3. Make sure you have the extras
npm i -g typescript eslint @tailwindcss/language-server
brew install lazygit   # or your package manager

# 4. Open Neovim
nvim
```

`lazy.nvim` will auto‑bootstrap and pull the rest.

---

## Keymaps (leader = **Space**)

| Action | Key |
|--------|-----|
| **Quick‑Open** file finder | `<leader><space>` |
| Live grep | `<leader>rg` |
| Toggle file tree | `<leader>e` |
| **lazygit (float)** | `<leader>lg` |
| Git blame line | `<leader>gb` |
| Git hunk preview | `<leader>gp` |
| Diagnostics float | `<leader>cd` |
| Next/prev diagnostic | `]d` / `[d` |
| Rename symbol | `<leader>rn` |

---

### Running Metro / Expo

Press `<leader>tt` to open a floating terminal, then run:

```bash
npx react-native start   # or npx expo start
```

Close the float with `<C-\><C-n>q`.

Enjoy!