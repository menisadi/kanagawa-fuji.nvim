# kanagawa-fuji.nvim

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

## Requirements

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)

## Installation

With `vim.pack` (Neovim 0.12+):

```lua
vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/menisadi/kanagawa-fuji.nvim",
})

vim.cmd.colorscheme("kanagawa-fuji")
```

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
	"menisadi/kanagawa-fuji.nvim",
	dependencies = { "rebelot/kanagawa.nvim" },
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("kanagawa-fuji")
	end,
}
```

## Usage

```vim
:colorscheme kanagawa-fuji
```

That's it - `colors/kanagawa-fuji.lua` registers a `fuji` theme (an alias
of kanagawa's `lotus` builder) and applies the tuned palette in one call.

Note: because the tuning overrides the shared `lotus*` palette keys
rather than introducing new ones, calling `:colorscheme kanagawa-lotus`
later in the same session will also reflect these overrides. That's
expected - it's how the underlying extension mechanism works.

## Credits

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) by
  [rebelot](https://github.com/rebelot) - this variant is built entirely
  on its public configuration API.
- Katsushika Hokusai, *South Wind, Clear Sky* ("Red Fuji"), from
  *Thirty-Six Views of Mount Fuji*.
