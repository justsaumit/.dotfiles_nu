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
    f = {
        name = "Telescope",
        f = {":Telescope find_files<CR>", "Telescope Find Files" },
        h = { ":Telescope find_files hidden=true<CR>", "Telescope Find Files" },
        g = { ":Telescope live_grep<CR>", "Telescope Live Grep" },
    },
    r = { ":Telescope oldfiles<CR>", "Recent files" },
    l = {
        name = "LSP",
        i = {":LspInfo<CR>", "Connected Language Servers"},
        I = {'<cmd>LspInstallInfo<cr>', 'Install language server'},
        f = {'<cmd>lua vim.lsp.buf.formatting()<CR>', "Format File"},
        k = {"<cmd> lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
        -- K = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"},
        K = {"<cmd> Lspsaga hover_doc<CR>", "Hover Commands"},
        w = {"<cmd> lua vim.lsp.add_workspace_folder()<CR>", "Add Workspace Folder"},
        W = {"<cmd> lua vim.lsp.remove_workspace_folder()<CR>", "Remove Workspace Folder"},
        l = {"<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folder"},
        t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type definition"},
        d = {"<cmd> lua vim.lsp.buf.definition()<CR>", "Go to Definition"},
        D = {"<cmd> lua vim.lsp.buf.declaration()<CR>", "Go to Declaration"},
        r = {"<cmd> lua vim.lsp.buf.references()<CR>", "References"},
        R = {"<cmd> Lspsaga rename<CR>", "Rename"},
        -- R = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
        a = {"<cmd> Lspsaga code_action<CR>", "Code Action"},
        -- a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions"},
        -- T = {'<cmd> Telescope diagnostics bufnr=0<CR>', "Get Diagnostics"}
        go = {"<cmd>Lspsaga show_line_diagnostics<CR>","Show Line Diagnostic"},
        -- e = {'<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', "Show line diagnostics"},
        gj = {"<cmd>Lspsaga diagnostic_jump_next<CR>","Go to Next Diagnostic"},
        -- n = {'<cmd>lua vim.diagnostic.goto_next()<CR>', "Go to next diagnostic"},
        gk = {"<cmd>Lspsaga diagnostic_jump_prev<CR>","Go to Prev Diagnostic"},
        -- N = {'<cmd>lua vim.diagnostic.goto_prev()<CR>', "Go to previous diagnostic"},
    },
    t = {
        name = "ToggleTerm",
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
