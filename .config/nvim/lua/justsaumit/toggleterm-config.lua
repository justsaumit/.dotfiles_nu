require'toggleterm'.setup{
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false,
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = '/usr/bin/zsh',
}
