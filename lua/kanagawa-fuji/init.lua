-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local M = {}

-- Every key here is a `lotus*` palette entry, and kanagawa only reads those
-- from its lotus theme builder, so injecting the whole table into the global
-- config leaves the wave and dragon themes untouched.
M.palette = {
	-- Backgrounds & UI
	lotusInk1 = "#3b5159",
	lotusWhite0 = "#b7bfb0",
	lotusWhite1 = "#f1dcb7",
	lotusWhite2 = "#f2ecd1",
	lotusWhite3 = "#fcf8ed",
	lotusWhite4 = "#d5ded4",
	lotusWhite5 = "#d5ceb4",

	-- Syntax accents
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
}

-- Merge the fuji palette *underneath* whatever is already configured, so an
-- explicit `lotus*` override in the user's kanagawa.setup() still wins. Writing
-- the merged table back makes this idempotent across repeated loads.
local function inject_palette(kanagawa)
	local colors = kanagawa.config.colors
	colors.palette = vim.tbl_extend("force", M.palette, colors.palette or {})
end

local load_wrapped = false

--- Register the fuji palette with kanagawa.
---@param opts? { override_lotus?: boolean }
---@return boolean ok whether kanagawa was available
function M.setup(opts)
	opts = opts or {}

	local ok, kanagawa = pcall(require, "kanagawa")
	if not ok then
		vim.notify("kanagawa-fuji requires rebelot/kanagawa.nvim", vim.log.levels.ERROR)
		return false
	end

	-- Register "fuji" as an alias of the built-in "lotus" builder so it can be
	-- loaded and selected like any other kanagawa theme.
	local themes = require("kanagawa.themes")
	themes.fuji = themes.lotus

	inject_palette(kanagawa)

	-- Re-inject on every load so the palette survives a kanagawa.setup() call
	-- that happens after this one, whatever the plugin load order.
	if opts.override_lotus and not load_wrapped then
		load_wrapped = true
		local load = kanagawa.load
		kanagawa.load = function(theme)
			inject_palette(kanagawa)
			return load(theme)
		end
	end

	return true
end

return M
