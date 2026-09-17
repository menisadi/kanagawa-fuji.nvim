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
| `lotusGray3` | `#8b9ba6` |
| `lotusGreen` | `#00815f` |
| `lotusAqua` | `#5d7277` |
| `lotusBlue4` | `#3a6a85` |
| `lotusBlue5` | `#275071` |
| `lotusViolet4` | `#1a3959` |
| `lotusRed` | `#ca0043` |
| `lotusOrange` | `#b94400` |
| `lotusPink` | `#c9007f` |
| `lotusYellow` | `#5c732f` |
| `lotusYellow2` | `#946100` |
| `lotusTeal1` | `#4c7988` |
| `lotusTeal2` | `#497d96` |

`lotusGray3` is the comment/deprecated color: the image cluster left it only
~1.6:1 from body text (`lotusInk1`), barely receding. Lightened to ~2.9:1.

`lotusGreen` is the string color (and, via `@string.documentation`'s fallback,
docstrings): the image cluster left it almost gray (chroma 0.025 of a 0.110
ceiling at that lightness). Re-saturated to the gamut boundary.

`lotusRed`, `lotusOrange`, `lotusPink`, `lotusYellow2`, and (below)
`lotusRed3`, `lotusOrange2`, `lotusRed2` were all within a 16deg hue wedge in
the original k-means cut — one undifferentiated terracotta-brown. Spread
across the same warm family and re-saturated to the gamut boundary, hue
chosen to also match what each key's name implies (`lotusPink` now actually
reads pink).

### Diagnostics

| palette key | hex |
|---|---|
| `lotusRed3` | `#8b0038` |
| `lotusOrange2` | `#876043` |
| `lotusTeal3` | `#4d636a` |
| `lotusAqua2` | `#547379` |

### VCS & non-text

Stock lotus leaves these at full saturation, which made them the only
unmuted colors in the theme and put them below AA on `lotusWhite3`.

| palette key | hex | role |
|---|---|---|
| `lotusGreen2` | `#5f7774` | added |
| `lotusYellow3` | `#777262` | changed |
| `lotusRed2` | `#db0024` | removed |
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

Unlike fuji, nami isn't derived from an image: every key below keeps stock
lotus's own hue (in OKLCH). The first cut of nami went further and held
chroma fixed too, but darkening a hue for contrast shrinks how much chroma
sRGB can hold at that lightness, so carrying over lotus's original chroma
silently gamut-clipped several hues toward the same low-saturation corner —
which is what made that cut read as flat and hard to tell apart. Chroma is
now re-derived instead: each syntax-role key is pushed back out toward the
sRGB gamut boundary at its own lightness, as far as it can go without
landing closer to another key than stock lotus's own hues already were. A
few hue families stock lotus placed close together to begin with
(red/pink, yellow2/yellow3, teal1/teal3 are all within ~10deg of a
neighbour) can't be pulled much further apart by chroma alone without that
collision, so those get a smaller, capped boost instead of the full one;
everything else reaches full gamut saturation. Contrast is still checked
the same way as before — full AA against `lotusWhite3` and against lotus's
own panel backgrounds (Visual, Pmenu, NormalFloat, CursorLine). Backgrounds
& UI are untouched, so they're the same as stock lotus above.

### Reds & pinks

| palette key | hex |
|---|---|
| `lotusRed` | `#a81838` |
| `lotusRed2` | `#8e001a` |
| `lotusRed3` | `#b1000d` |
| `lotusPink` | `#943258` |

`lotusRed3` is `diag.error`, reused unmuted by stock lotus at the same hex
as kanagawa's shared `samuraiRed` — but it's the key lotus actually reads.
`lotusRed`/`lotusPink` are one of the hue families stock lotus placed close
together (see above), so they get a smaller, capped boost rather than full
gamut saturation.

### Oranges & yellows

| palette key | hex |
|---|---|
| `lotusOrange` | `#864500` |
| `lotusOrange2` | `#804900` |
| `lotusYellow` | `#615700` |
| `lotusYellow2` | `#68532c` |
| `lotusYellow3` | `#764e00` |

`lotusYellow2`/`lotusYellow3` are the other capped pair (~10deg apart in
stock lotus); `lotusOrange`, `lotusOrange2` and `lotusYellow3` were already
at their own gamut ceiling in the first cut of nami, so they're unchanged.

### Greens, aquas & teals

| palette key | hex |
|---|---|
| `lotusGreen` | `#415f00` |
| `lotusGreen2` | `#2b6200` |
| `lotusAqua` | `#006158` |
| `lotusAqua2` | `#006251` |
| `lotusTeal1` | `#1a5d72` |
| `lotusTeal2` | `#005898` |
| `lotusTeal3` | `#3b5a6a` |

`lotusTeal1`/`lotusTeal3` are the third capped pair (~6deg apart in stock
lotus, the tightest of the three).

### Blues & violets

| palette key | hex |
|---|---|
| `lotusBlue4` | `#0046cb` |
| `lotusBlue5` | `#5900e6` |
| `lotusViolet4` | `#7600c6` |

`lotusViolet1` (`ui.nontext`/whitespace) and `lotusViolet2` (`ui.special`)
are UI chrome, not syntax roles that need to read apart from one another —
pulling them toward the same gamut boundary as the syntax accents above
crossed their much smaller chroma range through a neighbour's, so they (and
`lotusInk2`, `ui.fg_dim`) keep the first cut's lightness-only values.

| palette key | hex |
|---|---|
| `lotusViolet1` | `#585463` |
| `lotusViolet2` | `#4a4062` |
| `lotusInk2` | `#42416a` |

### Neutral accent

| palette key | hex |
|---|---|
| `lotusGray3` | `#a3a299` |

This is the comment/deprecated color. It was originally almost exactly as
light as body text (`lotusInk1`) — ~1.0:1 contrast, no dimming at all.
Lightened so comments actually recede (~2.9:1 against body text now).

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
