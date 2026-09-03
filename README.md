# kanagawa-fuji.nvim

![Katsushika Hokusai, South Wind, Clear Sky ("Red Fuji")](assets/red-fuji.jpg)

I'm a huge fan of [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) -
I've been using it for a while and genuinely love it. My only issue was its
light variant: I found it hard to read, and it turns out stock
`kanagawa-lotus` fails WCAG AA contrast on most of its syntax colors
against its own background.

kanagawa-fuji.nvim is my fix: a contrast- and hue-tuned take on `lotus`,
inspired by Hokusai's *South Wind, Clear Sky* ("Red Fuji") - a companion
piece to *The Great Wave off Kanagawa* in the *Thirty-Six Views of Mount
Fuji* series. It keeps the same soft, paper-like aesthetic but
darkens/saturates/rotates the accent colors that need it.
See [PALETTE.md](PALETTE.md) for the full color table.

This is **not** a fork of kanagawa.nvim and doesn't vendor any of its
code - it's built entirely through the plugin's own `colors.palette`/
`colors.theme` extension API, and it depends on kanagawa.nvim being
installed.

There are two ways to use it:

- **As a colorscheme** - `:colorscheme kanagawa-fuji`, sitting alongside
  kanagawa's own `wave`, `dragon` and `lotus`.
- **As a `lotus` override** - keep `:colorscheme kanagawa` and let this
  plugin swap its light variant for fuji, so `background=light` gives you
  fuji while `wave` and `dragon` stay untouched.

## Requirements

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)

## Installation

Install both plugins; pick a mode from [Usage](#usage) below.

With `vim.pack` (Neovim 0.12+):

```lua
vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/menisadi/kanagawa-fuji.nvim",
})
```

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
	"menisadi/kanagawa-fuji.nvim",
	dependencies = { "rebelot/kanagawa.nvim" },
	priority = 1000,
	config = function()
		-- one of the two snippets below
	end,
}
```

## Usage

### As a colorscheme

```lua
vim.cmd.colorscheme("kanagawa-fuji")
```

That's it - `colors/kanagawa-fuji.lua` registers `fuji` as a kanagawa
theme of its own, tuned from `lotus`, and loads it.

### As a `lotus` override

```lua
require("kanagawa-fuji").setup()
vim.cmd.colorscheme("kanagawa")
```

A light `background` resolves to fuji instead of lotus, while `wave` and
`dragon` stay untouched. Stock lotus is still there as
`:colorscheme kanagawa-lotus`.

## Credits

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) by
  [rebelot](https://github.com/rebelot) - this variant is built entirely
  on its public configuration API.
- Katsushika Hokusai, *South Wind, Clear Sky* ("Red Fuji"), from
  *Thirty-Six Views of Mount Fuji*.
