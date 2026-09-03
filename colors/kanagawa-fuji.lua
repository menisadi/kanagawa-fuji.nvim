-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local ok, kanagawa = pcall(require, "kanagawa")
if not ok then
	vim.notify("kanagawa-fuji requires rebelot/kanagawa.nvim", vim.log.levels.ERROR)
	return
end

-- Register "fuji" as an alias of the built-in "lotus" builder so it can be
-- loaded and selected like any other kanagawa theme.
local themes = require("kanagawa.themes")
themes.fuji = themes.lotus

kanagawa.setup({
	background = { light = "fuji" },
	colors = {
		palette = {
			-- Backgrounds & UI (unchanged from the original Fuji-derived palette;
			-- lotusWhite3 and several cool tones measured as near-exact matches
			-- to actual pixels in the source painting - see PALETTE.md)
			lotusInk1 = "#3b5159",
			lotusWhite0 = "#b7bfb0",
			lotusWhite1 = "#f1dcb7",
			lotusWhite2 = "#f2ecd1",
			lotusWhite3 = "#fcf8ed",
			lotusWhite4 = "#d5ded4",
			lotusWhite5 = "#d5ceb4",

			-- Syntax accents (contrast- and hue-tuned for WCAG AA legibility)
			lotusGray3 = "#61707b",
			lotusGreen = "#60726a",
			lotusAqua = "#5d7277",
			lotusBlue4 = "#3a6a85",
			lotusBlue5 = "#275071",
			lotusViolet4 = "#1a3959",
			lotusRed = "#a94d36",
			lotusOrange = "#a9523e",
			lotusPink = "#a75939",
			lotusYellow = "#5c732f",
			lotusYellow2 = "#915f4e",
			lotusTeal1 = "#4c7988",
			lotusTeal2 = "#497d96",
			lotusRed3 = "#55463e",
			lotusOrange2 = "#7c645a",
			lotusTeal3 = "#4d636a",
			lotusAqua2 = "#547379",
		},
	},
})

kanagawa.load("fuji")
