# Palette

kanagawa-fuji.nvim ships two tunings of stock `lotus`: [fuji](#fuji),
derived from a Hokusai print, and [nami](#nami), a direct lightness shift
that keeps lotus's own hues.

## fuji

This palette started from Hokusai's *South Wind, Clear Sky* ("Red Fuji"),
a companion piece to *The Great Wave off Kanagawa* in the *Thirty-Six
Views of Mount Fuji* series, as inspiration and a starting point. From
there, colors were adjusted to make the theme more accessible and
higher-contrast while keeping the same soft, muted feel.

The starting point was kanagawa's own
[`palette.py`](https://github.com/rebelot/kanagawa.nvim/blob/master/palette.py)
run over `assets/red-fuji.jpg`, which k-means the image in CIELAB. Where a
key needed more contrast than the image gave it, it was deepened along L\*
from its nearest cluster, so the hue stays the one Hokusai used.

### Backgrounds & UI

| palette key | hex |
|---|---|
| `lotusInk1` | `#3b5159` |
| `lotusWhite0` | `#cfcfbb` |
| `lotusWhite1` | `#f1dcb7` |
| `lotusWhite2` | `#f2ecd1` |
| `lotusWhite3` | `#fcf8ed` |
| `lotusWhite4` | `#d5ded4` |
| `lotusWhite5` | `#d5ceb4` |

### Syntax accents

| palette key | hex |
|---|---|
| `lotusGray3` | `#61707b` |
| `lotusGreen` | `#60726a` |
| `lotusAqua` | `#5d7277` |
| `lotusBlue4` | `#3a6a85` |
| `lotusBlue5` | `#275071` |
| `lotusViolet4` | `#1a3959` |
| `lotusRed` | `#a94d36` |
| `lotusOrange` | `#a9523e` |
| `lotusPink` | `#a75939` |
| `lotusYellow` | `#5c732f` |
| `lotusYellow2` | `#915f4e` |
| `lotusTeal1` | `#4c7988` |
| `lotusTeal2` | `#497d96` |

### Diagnostics

| palette key | hex |
|---|---|
| `lotusRed3` | `#55463e` |
| `lotusOrange2` | `#7c645a` |
| `lotusTeal3` | `#4d636a` |
| `lotusAqua2` | `#547379` |

### VCS & non-text

Stock lotus leaves these at full saturation, which made them the only
unmuted colors in the theme and put them below AA on `lotusWhite3`.

| palette key | hex | role |
|---|---|---|
| `lotusGreen2` | `#5f7774` | added |
| `lotusYellow3` | `#777262` | changed |
| `lotusRed2` | `#a4604f` | removed |
| `lotusViolet1` | `#758889` | line numbers, indent guides, inlay hints |

`lotusViolet1` deliberately stops at 3.5:1 rather than 4.5:1 — line numbers
and indent guides should sit behind the code, not level with it.

### Highlight overrides

Two groups cannot be fixed from the palette, because kanagawa paints them as
a dark foreground on a color this theme deepened into a foreground weight:

| group | kanagawa's spec | fuji |
|---|---|---|
| `@comment.error` | `fg = ui.fg`, `bg = diag.error` | `fg = #eadcbc` |
| `Substitute` | `fg = ui.fg`, `bg = vcs.removed` | `fg = #eadcbc` |

`#eadcbc` is the cloud cream, and is already how kanagawa draws the sibling
groups `@comment.warning`, `@comment.note` and `@comment.todo`. These apply
to fuji only; `wave`, `dragon` and `lotus` keep their own.

## nami

Unlike fuji, nami isn't derived from an image: every key below only moves
lightness relative to stock lotus's own value (in OKLCH) — hue and chroma
are held fixed, so the theme stays exactly as saturated and exactly as
many-hued as lotus, just dark enough on `lotusWhite3` and on lotus's own
panel backgrounds (Visual, Pmenu, NormalFloat, CursorLine) to clear AA.
Backgrounds & UI are untouched, so they're the same as stock lotus above.

### Reds & pinks

| palette key | hex |
|---|---|
| `lotusRed` | `#a71c39` |
| `lotusRed2` | `#8e001a` |
| `lotusRed3` | `#b1000d` |
| `lotusPink` | `#8e3958` |

`lotusRed3` is `diag.error`, reused unmuted by stock lotus at the same hex
as kanagawa's shared `samuraiRed` — but it's the key lotus actually reads.

### Oranges & yellows

| palette key | hex |
|---|---|
| `lotusOrange` | `#864500` |
| `lotusOrange2` | `#804900` |
| `lotusYellow` | `#5e5726` |
| `lotusYellow2` | `#67532f` |
| `lotusYellow3` | `#764e00` |

### Greens, aquas & teals

| palette key | hex |
|---|---|
| `lotusGreen` | `#465d23` |
| `lotusGreen2` | `#3e5e2f` |
| `lotusAqua` | `#3b5c57` |
| `lotusAqua2` | `#385d53` |
| `lotusTeal1` | `#1c5d72` |
| `lotusTeal2` | `#2e5982` |
| `lotusTeal3` | `#3e5a68` |

### Blues & violets

| palette key | hex |
|---|---|
| `lotusBlue4` | `#3c5687` |
| `lotusBlue5` | `#534d97` |
| `lotusViolet1` | `#585463` |
| `lotusViolet2` | `#4a4062` |
| `lotusViolet4` | `#624c82` |
| `lotusInk2` | `#42416a` |

### Neutral accent

| palette key | hex |
|---|---|
| `lotusGray3` | `#57564e` |

### UI surface

Unlike every key above, this one sits *under* text — Search/CurSearch/IncSearch
and the Pmenu scrollbar thumb — rather than being read as text on
`lotusWhite3`, so it needs lightening rather than darkening to clear AA
against that foreground.

| palette key | hex |
|---|---|
| `lotusBlue2` | `#b7ced5` |

### Highlight overrides

The same two groups as fuji, fixed the same way, but reusing kanagawa's own
`fujiWhite` rather than a separate literal:

| group | kanagawa's spec | nami |
|---|---|---|
| `@comment.error` | `fg = ui.fg`, `bg = diag.error` | `fg = fujiWhite` (`#DCD7BA`) |
| `Substitute` | `fg = ui.fg`, `bg = vcs.removed` | `fg = fujiWhite` (`#DCD7BA`) |

These apply to nami only; `wave`, `dragon` and `lotus` keep their own.
