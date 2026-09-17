-- kanagawa-nami: a contrast-tuned lotus variant for kanagawa.nvim that keeps
-- lotus's full, saturated hue set rather than narrowing it, inspired by
-- Hokusai's "The Great Wave off Kanagawa".
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local ok, nami = pcall(require, "kanagawa-nami")
if not ok then
	vim.notify("kanagawa-nami: unable to load the kanagawa-nami module", vim.log.levels.ERROR)
	return
end

-- setup() also points kanagawa's light `background` at nami. That is a global
-- side effect of a plain :colorscheme, but it is needed: kanagawa.load() always
-- sets g:colors_name = "kanagawa", so a later `:set background=light`
-- re-sources colors/kanagawa.vim, which would otherwise fall back to lotus.
if not nami.setup() then
	return
end

require("kanagawa").load("nami")
