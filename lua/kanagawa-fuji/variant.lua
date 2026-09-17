-- Shared machinery for the lotus variants this plugin ships (fuji and nami).
-- Both live in the same repo, so this sits under the kanagawa-fuji namespace
-- and nami requires it from there. `M.new` takes the three things that
-- actually differ between the variants - name, palette, and the foreground to
-- use on the backgrounds they deepen - and returns the variant's module.

local M = {}

-- Theme tables built by a variant carry that variant's name under this key.
-- The `overrides` hooks below are global across themes and must not repaint
-- wave/dragon/lotus, and tagging the theme table rather than reading
-- kanagawa's `_CURRENT_THEME` keeps that correct under `compile = true`, which
-- builds every theme in one pass without updating that field.
local MARKER = "__lotus_variant"

-- One `overrides` hook per registered variant, keyed by variant name so a
-- variant that registers twice never installs a second copy of itself.
-- Iteration order does not matter: every hook is gated on MARKER, so at most
-- one of them returns anything for any single theme build.
local hooks = {}

-- The `overrides` function the user had configured before we wrapped it.
local base

-- kanagawa's config merge replaces function values outright, so `overrides`
-- cannot be deep-extended the way `background` can. Compose by hand instead.
--
-- This is one stable function value that closes over `hooks` and `base` and
-- never over a previous wrapper, so installing it is idempotent: the wrapper
-- cannot stack however many variants register or however often the user
-- switches between them. The user's own overrides win over the variants'.
local function composed(colors)
	local result = {}

	for _, hook in pairs(hooks) do
		result = vim.tbl_extend("force", result, hook(colors))
	end

	return vim.tbl_extend("force", result, base and base(colors) or {})
end

local function install_overrides(kanagawa)
	if kanagawa.config.overrides == composed then
		return
	end

	-- Either this is the first registration, or the user called
	-- kanagawa.setup() with their own `overrides` after ours and replaced the
	-- wrapper. Either way, whatever is configured now is the base to wrap.
	base = kanagawa.config.overrides
	kanagawa.setup({ overrides = composed })
end

--- Build the module for one lotus variant.
---@param spec { name: string, palette: table<string, string>, fg_on_deep: fun(colors: table): string }
---@return table
function M.new(spec)
	local V = { palette = spec.palette }
	local plugin = "kanagawa-" .. spec.name

	-- Register the variant as its own theme builder: kanagawa's
	-- `colors.palette` is global (it is merged into the palette before any
	-- builder runs), so applying the tuning here instead keeps it scoped to
	-- this variant and leaves stock `lotus` alone.
	--
	-- Precedence: kanagawa's palette < the variant's tuning < the user's own
	-- `lotus*` keys.
	local function register_theme(kanagawa)
		local themes = require("kanagawa.themes")
		if themes[spec.name] then
			return
		end

		local lotus = themes.lotus
		themes[spec.name] = function(palette)
			local user = kanagawa.config.colors.palette or {}
			local theme = lotus(vim.tbl_extend("force", palette, V.palette, user))

			theme[MARKER] = spec.name

			return theme
		end
	end

	-- Two groups kanagawa paints as a dark foreground on a color the variants
	-- deepened:
	--
	--   @comment.error = { fg = ui.fg, bg = diag.error }   -- lotusRed3
	--   Substitute     = { fg = ui.fg, bg = vcs.removed }  -- lotusRed2
	--
	-- Both are dark-on-dark once those become foreground-weight colors, and no
	-- palette value can fix that: the same key is a foreground everywhere else
	-- (DiagnosticError, @diff.minus, the diff and git signs). Repaint them with
	-- the variant's light foreground instead, which is how kanagawa already
	-- draws the sibling groups @comment.warning, @comment.note and
	-- @comment.todo.
	hooks[spec.name] = function(colors)
		if colors.theme[MARKER] ~= spec.name then
			return {}
		end

		local fg = spec.fg_on_deep(colors)

		return {
			["@comment.error"] = { fg = fg, bg = colors.theme.diag.error, bold = true },
			Substitute = { fg = fg, bg = colors.theme.vcs.removed },
		}
	end

	--- Register the variant with kanagawa.
	---@param opts? { override_lotus?: boolean } `override_lotus` defaults to true
	---@return boolean ok whether kanagawa was available
	function V.setup(opts)
		opts = opts or {}

		local ok, kanagawa = pcall(require, "kanagawa")
		if not ok then
			vim.notify(plugin .. " requires rebelot/kanagawa.nvim", vim.log.levels.ERROR)
			return false
		end

		register_theme(kanagawa)
		install_overrides(kanagawa)

		-- Resolve a light `background` to this variant instead of lotus.
		-- kanagawa.setup() deep-extends, so this survives a later call from the
		-- user's own config.
		if opts.override_lotus ~= false then
			kanagawa.setup({ background = { light = spec.name } })
		end

		return true
	end

	return V
end

return M
