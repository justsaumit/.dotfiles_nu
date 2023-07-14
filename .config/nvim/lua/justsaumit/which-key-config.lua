local wk = require("which-key")
local mappings = {
    q = {":q<CR>", "Quit"},
    Z = {":wq<CR>", "Save and Quit"},
    w = {":w<CR>", "Save"},
    x ={":bdelete<CR>", "Close"},
    f = { ":Telescope find_files<CR>", "Telescope Find Files" },
    h = { ":Telescope find_files hidden=true<CR>", "Telescope Find Files" },
    g = { ":Telescope live_grep<CR>", "Telescope Live Grep" },
    r = { ":Telescope oldfiles<CR>", "Recent files" }
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
