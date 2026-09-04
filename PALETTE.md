# Palette

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

## Backgrounds & UI

| palette key | hex |
|---|---|
| `lotusInk1` | `#3b5159` |
| `lotusWhite0` | `#cfcfbb` |
| `lotusWhite1` | `#f1dcb7` |
| `lotusWhite2` | `#f2ecd1` |
| `lotusWhite3` | `#fcf8ed` |
| `lotusWhite4` | `#d5ded4` |
| `lotusWhite5` | `#d5ceb4` |

## Syntax accents

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

## Diagnostics

| palette key | hex |
|---|---|
| `lotusRed3` | `#55463e` |
| `lotusOrange2` | `#7c645a` |
| `lotusTeal3` | `#4d636a` |
| `lotusAqua2` | `#547379` |

## VCS & non-text

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

## Highlight overrides

Two groups cannot be fixed from the palette, because kanagawa paints them as
a dark foreground on a color this theme deepened into a foreground weight:

| group | kanagawa's spec | fuji |
|---|---|---|
| `@comment.error` | `fg = ui.fg`, `bg = diag.error` | `fg = #eadcbc` |
| `Substitute` | `fg = ui.fg`, `bg = vcs.removed` | `fg = #eadcbc` |

`#eadcbc` is the cloud cream, and is already how kanagawa draws the sibling
groups `@comment.warning`, `@comment.note` and `@comment.todo`. These apply
to fuji only; `wave`, `dragon` and `lotus` keep their own.
