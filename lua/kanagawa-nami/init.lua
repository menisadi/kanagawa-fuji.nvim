-- kanagawa-nami: a contrast-tuned lotus variant for kanagawa.nvim that keeps
-- lotus's full, saturated hue set rather than narrowing it, inspired by
-- Hokusai's "The Great Wave off Kanagawa".
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local palette = {
	-- Reds / pinks
	lotusRed = "#a81838",
	lotusRed2 = "#8e001a",
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
	lotusViolet1 = "#585463",
	lotusViolet2 = "#4a4062",
	lotusViolet4 = "#7600c6",
	lotusInk2 = "#42416a",

	-- Neutral accent
	lotusGray3 = "#a3a299",

	-- UI surface
	lotusBlue2 = "#b7ced5",
}

return require("kanagawa-fuji.variant").new({
	name = "nami",
	palette = palette,
	fg_on_deep = function(colors)
		return colors.palette.fujiWhite
	end,
})
