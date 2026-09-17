-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local palette = {
	-- Backgrounds & UI
	lotusInk1 = "#3b5159",
	lotusWhite0 = "#cfcfbb",
	lotusWhite1 = "#f1dcb7",
	lotusWhite2 = "#f2ecd1",
	lotusWhite3 = "#fcf8ed",
	lotusWhite4 = "#d5ded4",
	lotusWhite5 = "#d5ceb4",

	-- Syntax accents
	lotusGray3 = "#8b9ba6",
	lotusGreen = "#00815f",
	lotusAqua = "#5d7277",
	lotusBlue4 = "#3a6a85",
	lotusBlue5 = "#275071",
	lotusViolet4 = "#1a3959",
	lotusRed = "#ca0043",
	lotusOrange = "#b94400",
	lotusPink = "#c9007f",
	lotusYellow = "#5c732f",
	lotusYellow2 = "#946100",
	lotusTeal1 = "#4c7988",
	lotusTeal2 = "#497d96",
	lotusRed3 = "#8b0038",
	lotusOrange2 = "#876043",
	lotusTeal3 = "#4d636a",
	lotusAqua2 = "#547379",

	-- VCS and non-text
	lotusGreen2 = "#5f7774",
	lotusYellow3 = "#777262",
	lotusRed2 = "#db0024",
	lotusViolet1 = "#758889",
}

local FG_ON_DEEP = "#eadcbc"

return require("kanagawa-fuji.variant").new({
	name = "fuji",
	palette = palette,
	fg_on_deep = function()
		return FG_ON_DEEP
	end,
})
