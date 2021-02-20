local function createFloatingWindow()
    local stats = vim.api.nvim_list_uis()[1]
    local width = stats.width
    local height = stats.height

    local dim_height = math.ceil(width*0.8)
    local dim_width = math.ceil(width*0.8 - 4)

    local row = math.ceil((height - dim_height) / 2 - 1)
    local col = math.ceil((width - dim_width))

    local bufh = vim.api.nvim_create_buf(false, true)
    local bufh_opts = {
        style='minimal',
        relative="editor",
        width=width-3,
        height=height-3,
        col=col,
        row=row,
    }

    local border_opts = {
        style = "minimal",
        relative = "editor",
        width = dim_width + 2,
        height = dim_height + 2,
        row = row - 1,
        col = col - 1
    }

    local border_buf = vim.api.nvim_create_buf(false, true)
    local border_lines = { '╔' .. string.rep('═', dim_width) .. '╗' }
    local middle_line = '║' .. string.rep(' ', dim_width) .. '║'
    for i=1, dim_height do
          table.insert(border_lines, middle_line)
    end

    table.insert(border_lines, '╚' .. string.rep('═', dim_width) .. '╝')
    vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

    local border_win = vim.api.nvim_open_win(border_buf, true, border_opts)
    vim.api.nvim_open_win(bufh, true, bufh_opts)
    vim.api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
end

local function onResize()
    local stats = vim.api.nvim_list_uis()[1]
    local width = stats.width
    local height = stats.height

    print(width, height)
    return width, height
end


return {
    createFloatingWindow = createFloatingWindow,
    onResize = onResize
}
