-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local M = {}

-- Every key here is a `lotus*` palette entry. Fuji's theme builder below
-- merges this table over kanagawa's own palette, so nothing outside the fuji
-- theme ever sees these values.
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

	-- VCS and non-text. Stock lotus leaves these bright and saturated, which
	-- makes them the only unmuted colors in the theme and drops them below AA
	-- on lotusWhite3. Re-derived from the Red Fuji clusters like the rest.
	lotusGreen2 = "#5f7774",
	lotusYellow3 = "#777262",
	lotusRed2 = "#a4604f",
	lotusViolet1 = "#758889",
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
		local theme = lotus(vim.tbl_extend("force", palette, M.palette, user))

		-- Marker for the `overrides` below, which is global across themes and
		-- must not repaint wave/dragon/lotus. Tagging the theme table rather
		-- than reading kanagawa's `_CURRENT_THEME` keeps this correct under
		-- `compile = true`, which builds every theme in one pass without
		-- updating that field.
		theme._fuji = true

		return theme
	end
end

-- Two groups kanagawa paints as a dark foreground on a color fuji deepened:
--
--   @comment.error = { fg = ui.fg, bg = diag.error }   -- lotusRed3
--   Substitute     = { fg = ui.fg, bg = vcs.removed }  -- lotusRed2
--
-- Both are dark-on-dark once those become foreground-weight colors, and no
-- palette value can fix that: the same key is a foreground everywhere else
-- (DiagnosticError, @diff.minus, the diff and git signs). Repaint them with
-- the cloud cream instead, which is how kanagawa already draws the sibling
-- groups @comment.warning, @comment.note and @comment.todo.
local FG_ON_DEEP = "#eadcbc"

local function fuji_overrides(colors)
	if not colors.theme._fuji then
		return {}
	end

	return {
		["@comment.error"] = { fg = FG_ON_DEEP, bg = colors.theme.diag.error, bold = true },
		Substitute = { fg = FG_ON_DEEP, bg = colors.theme.vcs.removed },
	}
end

-- kanagawa's config merge replaces function values outright, so `overrides`
-- cannot be deep-extended the way `background` can. Compose by hand and keep
-- the user's own overrides winning over fuji's.
local composed

local function register_overrides(kanagawa)
	local previous = kanagawa.config.overrides
	if previous == composed then
		return
	end

	composed = function(colors)
		return vim.tbl_extend("force", fuji_overrides(colors), previous(colors) or {})
	end

	kanagawa.setup({ overrides = composed })
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
	register_overrides(kanagawa)

	-- Resolve a light `background` to fuji instead of lotus. kanagawa.setup()
	-- deep-extends, so this survives a later call from the user's own config.
	if opts.override_lotus ~= false then
		kanagawa.setup({ background = { light = "fuji" } })
	end

	return true
end

return M
