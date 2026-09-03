# Palette reference

A contrast- and hue-tuned take on kanagawa.nvim's `lotus` (light) theme,
implemented as a `colors.palette` override on top of the stock `lotus`
theme builder (see `colors/kanagawa-fuji.lua`). Colors were adjusted to
clear WCAG AA contrast (4.5:1) against the background and to keep enough
hue separation from it (background hue is 44°, warm cream) that no syntax
color reads as washed-out.

## Backgrounds & UI

| palette key | hex | role |
|---|---|---|
| `lotusInk1` | `#3b5159` | main text (7.89:1 vs bg) |
| `lotusWhite3` | `#fcf8ed` | background |
| `lotusWhite0` | `#b7bfb0` | bg shade -3 |
| `lotusWhite1` | `#f1dcb7` | bg shade -2 |
| `lotusWhite2` | `#f2ecd1` | bg shade -1 |
| `lotusWhite4` | `#d5ded4` | bg shade +1 / gutter |
| `lotusWhite5` | `#d5ceb4` | bg shade +2 |

## Syntax accents

| palette key | hex | role | contrast vs bg | hue-dist. from bg |
|---|---|---|---|---|
| `lotusViolet4` | `#1a3959` | keyword, statement | 11.16:1 | 166° |
| `lotusBlue5` | `#275071` | parameter | 8.00:1 | 163° |
| `lotusBlue4` | `#3a6a85` | function | 5.53:1 | 158° |
| `lotusRed` | `#a94d36` | preproc, special2/3 | 5.21:1 | 32° |
| `lotusYellow` | `#5c732f` | identifier | 5.01:1 | 36° |
| `lotusYellow2` | `#915f4e` | operator, regex | 5.01:1 | 29° |
| `lotusOrange` | `#a9523e` | constant | 4.99:1 | 33° |
| `lotusGray3` | `#61707b` | comment, deprecated | 4.81:1 | 161° |
| `lotusGreen` | `#60726a` | string, diag ok | 4.81:1 | 109° |
| `lotusPink` | `#a75939` | number | 4.79:1 | 27° |
| `lotusAqua` | `#5d7277` | type | 4.78:1 | 148° |
| `lotusTeal1` | `#4c7988` | punctuation | 4.50:1 | 151° |

`lotusInk1`, `lotusBlue4`, `lotusBlue5`, `lotusViolet4`, and `lotusTeal1`
are unchanged from the original Fuji-derived palette — they already
cleared AA. Everything else in this table was darkened/saturated to reach
≥4.5:1, and `lotusGray3` (comment) and `lotusYellow` (identifier) were
also hue-rotated off the background's warm hue to fix hue-crowding
(colors that only clear contrast on lightness but share the background's
hue still read as washed-out).

## Diagnostics (unchanged, kept as originally chosen)

| palette key | hex | role | contrast vs bg |
|---|---|---|---|
| `lotusRed3` | `#55463e` | diag error | 8.49:1 |
| `lotusTeal3` | `#4d636a` | diag info | 5.98:1 |
| `lotusOrange2` | `#7c645a` | diag warning | 5.17:1 |
| `lotusAqua2` | `#547379` | diag hint | 4.82:1 |

## Known gap

`lotusTeal2` (`#497d96`, used for `special1` — e.g. regex escapes) sits at
4.25:1, just under AA. It wasn't part of the original 12-role audit and
hasn't been retuned yet.

## Provenance

The starting palette (before the accessibility tuning above) was inspired
by Hokusai's *South Wind, Clear Sky* ("Red Fuji"), a companion piece to
*The Great Wave off Kanagawa* in the *Thirty-Six Views of Mount Fuji*
series. This was checked against the actual painting, not just asserted:
quantizing the source image to its 16 most dominant colors and measuring
RGB distance from each palette value gives a mixed, honest picture:

- **Genuinely, near-exactly sampled**: the background and the whole cool
  blue/teal/ink family. `lotusWhite3` (`#fcf8ed`) matches a dominant pixel
  color in the source image at 0.0 distance; `lotusBlue4`, `lotusTeal1`,
  `lotusTeal3`, `lotusBlue5` all land within ~5-12 units of a real
  dominant color in the painting.
- **Loosely related at best**: the warm reds/oranges/pinks sit 30-36
  units from the nearest real dominant color — same general family, not
  an exact match.
- **Not from the painting at all**: `lotusYellow` (identifier) was
  invented via a pure HSL hue-rotation during the accessibility pass and
  has no connection to the source image (54.7 units from its nearest
  real-color match, the worst in the palette).

So: half genuine extraction, half accessibility-driven invention. That's
consistent with how kanagawa.nvim's own bundled `palette.py` tool implies
its palettes were made — extraction-informed, then hand-curated - just
made explicit and checked with numbers here.
