local api = vim.api
local win, bufh

local function center(str)
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width/2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str
end

local function centerColumn(str, col)
    local width = api.nvim_win_get_width(0)
end


function fileChecker()
    local f=io.open('.todo.md', 'r')
    local file_contents = f:read("*a")
    local titles = {}

    local file= io.open('.todo.md', 'a+')
    titles[0] = file:read()
    print(file:read('*a'))
    local columns = #titles
    print(columns)
    --file:write("- [ ] TEST")
    --file:write("\n  - [ ] SUBTEST")
    --file:write("\n    - [ ] SUB SUBTEST")
    --file:write("\n  - [ ] SUBTEST 2")
    --file:write("\n    - [ ] SUB SUBTEST")
    --file:write("\n    - [ ] SUB SUBTEST 2")

    return columns, titles
end


local function createFloatingWindow()
    buf = vim.api.nvim_create_buf(false, true)
    local border_buf = vim.api.nvim_create_buf(false, true)

    local cols, titles = fileChecker()
    print(cols)

    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'whid')

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local border_opts = {
        style = "minimal",
        relative = "editor",
        width = win_width + 2,
        height = win_height + 2,
        row = row - 1,
        col = col - 1
    }

    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    local column_opts = {
        style = 'minimal',
        relative = 'editor',
        width = win_width/3,
        height = win_height,
        row = row,
        col = col
    }

    local lb = math.floor(win_width/3)
    local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
    local middle_line = '║' .. string.rep(' ', win_width) .. '║'
    for i=1, win_height do
        table.insert(border_lines, middle_line)
    end
    table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')
    vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

    local border_win = vim.api.nvim_open_win(border_buf, true, border_opts)
    win = api.nvim_open_win(buf, true, opts)

    api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)

    vim.api.nvim_win_set_option(win, 'cursorline', true)

    api.nvim_buf_set_lines(buf, 0, -1, false, { center('Vim-Kanban'), '', ''})
    api.nvim_buf_set_lines(buf, 1, -1, false, { center(titles[0]), '', ''})
    api.nvim_buf_add_highlight(buf, -1, 'WhidHeader', 0, 0, -1)
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
