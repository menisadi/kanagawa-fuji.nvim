-- kanagawa-fuji: a contrast- and hue-tuned lotus variant for kanagawa.nvim,
-- inspired by Hokusai's "South Wind, Clear Sky" (Red Fuji).
-- Requires https://github.com/rebelot/kanagawa.nvim to be installed.

local ok, fuji = pcall(require, "kanagawa-fuji")
if not ok then
	vim.notify("kanagawa-fuji: unable to load the kanagawa-fuji module", vim.log.levels.ERROR)
	return
end

if not fuji.setup() then
	return
end

local kanagawa = require("kanagawa")
kanagawa.setup({ background = { light = "fuji" } })
kanagawa.load("fuji")
