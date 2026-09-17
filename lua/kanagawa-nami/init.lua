-- kanagawa-nami: a contrast-tuned lotus variant for kanagawa.nvim that keeps
-- lotus's full, saturated hue set rather than narrowing it, inspired by
-- Hokusai's "The Great Wave off Kanagawa".
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

-- Same hue as stock lotus (OKLCH), but chroma is re-derived rather than
-- inherited: holding it fixed while darkening gamut-clips it, which is what
-- flattened the first cut of this palette. Each key is pushed back toward
-- the sRGB gamut boundary, capped only where that would collide with a
-- neighbouring hue (red/pink, yellow2/yellow3, teal1/teal3). Still clears
-- full AA against lotusWhite3 and lotus's panel backgrounds, as before.
local palette = {
	-- Reds / pinks
	lotusRed = "#a81838",
	lotusRed2 = "#8e001a",
	-- diag.error, reused unmuted by stock lotus at the same hex as
	-- kanagawa's shared samuraiRed, but this is the key lotus actually reads.
	lotusRed3 = "#b1000d",
	lotusPink = "#943258",

	-- Oranges / yellows
	lotusOrange = "#864500",
	lotusOrange2 = "#804900",
	lotusYellow = "#615700",
	lotusYellow2 = "#68532c",
	lotusYellow3 = "#764e00",

	-- Greens / aquas / teals
	lotusGreen = "#415f00",
	lotusGreen2 = "#2b6200",
	lotusAqua = "#006158",
	lotusAqua2 = "#006251",
	lotusTeal1 = "#1a5d72",
	lotusTeal2 = "#005898",
	lotusTeal3 = "#3b5a6a",

	-- Blues / violets
	lotusBlue4 = "#0046cb",
	lotusBlue5 = "#5900e6",
	-- UI chrome, not a syntax role -- left at its original lightness-only value.
	lotusViolet1 = "#585463",
	lotusViolet2 = "#4a4062",
	lotusViolet4 = "#7600c6",
	lotusInk2 = "#42416a",

	-- Neutral accent. Comment/deprecated color -- the previous value was almost
	-- exactly as light as body text (contrast 1.0:1, no dimming at all);
	-- lightened so it actually recedes (~2.3:1 against body text now).
	lotusGray3 = "#919087",

	-- UI surface, not a syntax swatch: Search/CurSearch/IncSearch and the
	-- Pmenu scrollbar thumb sit *under* lotusInk1 rather than being read as
	-- text on lotusWhite3, so unlike everything else above it needs lightening
	-- rather than darkening to clear AA against that fg.
	lotusBlue2 = "#b7ced5",
}

return require("kanagawa-fuji.variant").new({
	name = "nami",
	palette = palette,
	-- Nami holds lotus's hues fixed, so kanagawa's own `fujiWhite` is the right
	-- light foreground here - and reading it from the palette rather than
	-- hardcoding it follows a user who overrides that key.
	fg_on_deep = function(colors)
		return colors.palette.fujiWhite
	end,
})
