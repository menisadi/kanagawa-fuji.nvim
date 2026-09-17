-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

-- Every key here is a `lotus*` palette entry. The variant builder merges this
-- table over kanagawa's own palette, so nothing outside the fuji theme ever
-- sees these values.
local palette = {
	-- Backgrounds & UI
	lotusInk1 = "#3b5159",
	-- The pale-olive cluster rather than the sage one. Sage is closer to the
	-- painting's midtones, but as the float, statusline and tabline background
	-- it sat dark enough to sink the text on top of it.
	lotusWhite0 = "#cfcfbb",
	lotusWhite1 = "#f1dcb7",
	lotusWhite2 = "#f2ecd1",
	lotusWhite3 = "#fcf8ed",
	lotusWhite4 = "#d5ded4",
	lotusWhite5 = "#d5ceb4",

	-- Syntax accents
	-- Comment/deprecated color, lightened further from the image cluster so it
	-- actually recedes from body text (was contrast 1.6:1 against it, now ~2.9:1).
	lotusGray3 = "#8b9ba6",
	-- String color, re-saturated to the gamut boundary at the same hue/lightness
	-- -- the image cluster left it almost gray (chroma 0.025 of a 0.110 ceiling).
	lotusGreen = "#00815f",
	lotusAqua = "#5d7277",
	lotusBlue4 = "#3a6a85",
	lotusBlue5 = "#275071",
	lotusViolet4 = "#1a3959",
	-- lotusRed/Orange/Pink/Yellow2/Red3/Orange2/Red2 were all within a 16deg
	-- hue wedge in the original k-means cut (basically all "terracotta-brown"),
	-- which read as too samey/yellowish. Spread apart across the same warm
	-- family and re-saturated to the sRGB gamut boundary, hue chosen to also
	-- match what each key's name implies (lotusPink now actually reads pink).
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

	-- VCS and non-text. Stock lotus leaves these bright and saturated, which
	-- makes them the only unmuted colors in the theme and drops them below AA
	-- on lotusWhite3. Re-derived from the Red Fuji clusters like the rest.
	lotusGreen2 = "#5f7774",
	lotusYellow3 = "#777262",
	lotusRed2 = "#db0024",
	lotusViolet1 = "#758889",
}

-- The cloud cream fuji uses wherever it has to paint a light foreground on one
-- of the colors it deepened. Fuji rotates hue as well as lightness, so this is
-- its own value rather than kanagawa's `fujiWhite`.
local FG_ON_DEEP = "#eadcbc"

return require("kanagawa-fuji.variant").new({
	name = "fuji",
	palette = palette,
	fg_on_deep = function()
		return FG_ON_DEEP
	end,
})
