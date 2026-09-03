-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local ok, fuji = pcall(require, "kanagawa-fuji")
if not ok then
	vim.notify("kanagawa-fuji: unable to load the kanagawa-fuji module", vim.log.levels.ERROR)
	return
end

-- setup() also points kanagawa's light `background` at fuji. That is a global
-- side effect of a plain :colorscheme, but it is needed: kanagawa.load() always
-- sets g:colors_name = "kanagawa", so a later `:set background=light`
-- re-sources colors/kanagawa.vim, which would otherwise fall back to lotus.
if not fuji.setup() then
	return
end

require("kanagawa").load("fuji")
