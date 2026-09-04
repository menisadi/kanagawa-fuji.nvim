-- kanagawa-nami: a contrast-tuned lotus variant for kanagawa.nvim that keeps
-- lotus's full, saturated hue set rather than narrowing it, inspired by
-- Hokusai's "The Great Wave off Kanagawa".
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local M = {}

-- Every value here only moves lightness relative to stock lotus: hue and
-- chroma are held fixed (OKLCH), so the palette stays exactly as saturated
-- and exactly as many-hued as lotus, just dark enough on lotusWhite3 and on
-- lotus's own panel backgrounds (Visual, Pmenu, NormalFloat, CursorLine) to
-- clear AA.
M.palette = {
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

-- Register "nami" as its own theme builder: kanagawa's `colors.palette` is
-- global (it is merged before any builder runs), so applying the tuning here
-- instead keeps it scoped to nami and leaves stock `lotus` alone.
--
-- Precedence: kanagawa's palette < nami tuning < the user's own `lotus*` keys.
local function register_theme(kanagawa)
	local themes = require("kanagawa.themes")
	if themes.nami then
		return
	end

	local lotus = themes.lotus
	themes.nami = function(palette)
		local user = kanagawa.config.colors.palette or {}
		local theme = lotus(vim.tbl_extend("force", palette, M.palette, user))

		-- Marker for the `overrides` below, which is global across themes and
		-- must not repaint wave/dragon/lotus. Tagging the theme table rather
		-- than reading kanagawa's `_CURRENT_THEME` keeps this correct under
		-- `compile = true`, which builds every theme in one pass without
		-- updating that field.
		theme._nami = true

		return theme
	end
end

-- Two groups kanagawa paints as a dark foreground on a color nami deepened:
--
--   @comment.error = { fg = ui.fg, bg = diag.error }   -- lotusRed3
--   Substitute     = { fg = ui.fg, bg = vcs.removed }  -- lotusRed2
--
-- Both are dark-on-dark once those become foreground-weight colors, and no
-- palette value can fix that: the same key is a foreground everywhere else
-- (DiagnosticError, @diff.minus, the diff and git signs). Repaint them with
-- fujiWhite instead, which is how stock lotus already draws the sibling
-- groups @comment.warning, @comment.note and @comment.todo, and it's
-- untouched by the tuning above.
local function nami_overrides(colors)
	if not colors.theme._nami then
		return {}
	end

	local fg_on_deep = colors.palette.fujiWhite

	return {
		["@comment.error"] = { fg = fg_on_deep, bg = colors.theme.diag.error, bold = true },
		Substitute = { fg = fg_on_deep, bg = colors.theme.vcs.removed },
	}
end

-- kanagawa's config merge replaces function values outright, so `overrides`
-- cannot be deep-extended the way `background` can. Compose by hand and keep
-- the user's own overrides winning over nami's.
local composed

local function register_overrides(kanagawa)
	local previous = kanagawa.config.overrides
	if previous == composed then
		return
	end

	composed = function(colors)
		return vim.tbl_extend("force", nami_overrides(colors), previous(colors) or {})
	end

	kanagawa.setup({ overrides = composed })
end

--- Register the nami theme with kanagawa.
---@param opts? { override_lotus?: boolean } `override_lotus` defaults to true
---@return boolean ok whether kanagawa was available
function M.setup(opts)
	opts = opts or {}

	local ok, kanagawa = pcall(require, "kanagawa")
	if not ok then
		vim.notify("kanagawa-nami requires rebelot/kanagawa.nvim", vim.log.levels.ERROR)
		return false
	end

	register_theme(kanagawa)
	register_overrides(kanagawa)

	-- Resolve a light `background` to nami instead of lotus. kanagawa.setup()
	-- deep-extends, so this survives a later call from the user's own config.
	if opts.override_lotus ~= false then
		kanagawa.setup({ background = { light = "nami" } })
	end

	return true
end

return M
