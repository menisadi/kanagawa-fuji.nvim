-- kanagawa-nami: a contrast-tuned lotus variant for kanagawa.nvim that keeps
-- lotus's full, saturated hue set rather than narrowing it, inspired by
-- Hokusai's "The Great Wave off Kanagawa".
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

-- Every value here only moves lightness relative to stock lotus: hue and
-- chroma are held fixed (OKLCH), so the palette stays exactly as saturated
-- and exactly as many-hued as lotus, just dark enough on lotusWhite3 and on
-- lotus's own panel backgrounds (Visual, Pmenu, NormalFloat, CursorLine) to
-- clear AA.
local palette = {
	-- Reds / pinks
	lotusRed = "#a71c39",
	lotusRed2 = "#8e001a",
	-- diag.error, reused unmuted by stock lotus at the same hex as
	-- kanagawa's shared samuraiRed, but this is the key lotus actually reads.
	lotusRed3 = "#b1000d",
	lotusPink = "#8e3958",

	-- Oranges / yellows
	lotusOrange = "#864500",
	lotusOrange2 = "#804900",
	lotusYellow = "#5e5726",
	lotusYellow2 = "#67532f",
	lotusYellow3 = "#764e00",

	-- Greens / aquas / teals
	lotusGreen = "#465d23",
	lotusGreen2 = "#3e5e2f",
	lotusAqua = "#3b5c57",
	lotusAqua2 = "#385d53",
	lotusTeal1 = "#1c5d72",
	lotusTeal2 = "#2e5982",
	lotusTeal3 = "#3e5a68",

	-- Blues / violets
	lotusBlue4 = "#3c5687",
	lotusBlue5 = "#534d97",
	lotusViolet1 = "#585463",
	lotusViolet2 = "#4a4062",
	lotusViolet4 = "#624c82",
	lotusInk2 = "#42416a",

	-- Neutral accent
	lotusGray3 = "#57564e",

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
