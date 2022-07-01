local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
  vim.notify("nightfox is not installed!")
end

nightfox.setup({
  options = {
    transparent = true,
  }
})
  


vim.g["tokyonight_style"] = "night"
vim.g["tokyonight_transparent"] = false
local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
