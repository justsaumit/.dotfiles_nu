local wk = require("which-key")
local Terminal = require('toggleterm.terminal').Terminal
local toggle_float = function()
  local float = Terminal:new({ direction = "float" })
  return float:toggle()
end
local toggle_lazygit = function()
  local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
  return lazygit:toggle()
end
local mappings = {
    q = {":q<CR>", "Quit"},
    Z = {":wq<CR>", "Save and Quit"},
    w = {":w<CR>", "Save"},
    x ={":bdelete<CR>", "Close"},
    E = { ":e ~/.config/nvim/init.lua<cr>", "Edit config" },
    f = { ":Telescope find_files<CR>", "Telescope Find Files" },
    h = { ":Telescope find_files hidden=true<CR>", "Telescope Find Files" },
    g = { ":Telescope live_grep<CR>", "Telescope Live Grep" },
    r = { ":Telescope oldfiles<CR>", "Recent files" },
    t = {
        t = { ":ToggleTerm<cr>", "Split Below" },
        f = { toggle_float, "Floating Terminal" },
        l = { toggle_lazygit, "Lazygit" },
    },
    p = {
        name = "Packer",
        s = { ":PackerSync<cr>", "Sync Plugins" },
        r = { ":PackerClean<cr>", "Remove Unused Plugins" },
        c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
        i = { ":PackerInstall<cr>", "Install Plugins" },
        p = { ":PackerProfile<cr>", "Packer Profile" },
        S = { ":PackerStatus<cr>", "Packer Status" },
        u = { ":PackerUpdate<cr>", "Update Plugins" }
  },
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
