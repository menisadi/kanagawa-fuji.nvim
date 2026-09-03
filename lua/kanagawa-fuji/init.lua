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

-- Register "fuji" as its own theme builder: kanagawa's `colors.palette` is
-- global (it is merged before any builder runs), so applying the tuning here
-- instead keeps it scoped to fuji and leaves stock `lotus` alone.
--
-- Precedence: kanagawa's palette < fuji tuning < the user's own `lotus*` keys.
local function register_theme(kanagawa)
	local themes = require("kanagawa.themes")
	if themes.fuji then
		return
	end

	local lotus = themes.lotus
	themes.fuji = function(palette)
		local user = kanagawa.config.colors.palette or {}
		return lotus(vim.tbl_extend("force", palette, M.palette, user))
	end
end

--- Register the fuji theme with kanagawa.
---@param opts? { override_lotus?: boolean } `override_lotus` defaults to true
---@return boolean ok whether kanagawa was available
function M.setup(opts)
	opts = opts or {}

	local ok, kanagawa = pcall(require, "kanagawa")
	if not ok then
		vim.notify("kanagawa-fuji requires rebelot/kanagawa.nvim", vim.log.levels.ERROR)
		return false
	end

	register_theme(kanagawa)

	-- Resolve a light `background` to fuji instead of lotus. kanagawa.setup()
	-- deep-extends, so this survives a later call from the user's own config.
	if opts.override_lotus ~= false then
		kanagawa.setup({ background = { light = "fuji" } })
	end

	return true
end

return M
