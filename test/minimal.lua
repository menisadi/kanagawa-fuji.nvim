-- Minimal config for testing kanagawa-fuji.nvim's override_lotus mode:
--   nvim --clean -u test/minimal.lua [file]
--   KANAGAWA_THEME=nami nvim --clean -u test/minimal.lua [file]
--
-- 'background' is deliberately left unset so the theme follows the terminal
-- (light -> fuji/nami, dark -> wave); `:set background=dark` toggles it by
-- hand. Prefix XDG_STATE_HOME=/tmp/kf-state when testing kanagawa's
-- compile = true.
local here = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
local root = vim.fn.fnamemodify(here, ":h")
local kanagawa = here .. "/.deps/kanagawa.nvim"

if vim.fn.isdirectory(kanagawa) == 0 then
	vim.fn.mkdir(here .. "/.deps", "p")
	vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/rebelot/kanagawa.nvim", kanagawa })
end

vim.opt.rtp:prepend(kanagawa)
vim.opt.rtp:prepend(root)

vim.o.termguicolors = true

local light_theme = vim.env.KANAGAWA_THEME or "fuji"
require("kanagawa-" .. light_theme).setup({ override_lotus = true })
vim.cmd.colorscheme("kanagawa")
