local api = vim.api
local win, bufh

local function center(str)
    --local width = lb
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width/2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str
end


local function createFloatingWindow()
  buf = vim.api.nvim_create_buf(false, true)
  local border_buf = vim.api.nvim_create_buf(false, true)

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

  local lb = math.floor(win_width/3)-3
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
  api.nvim_buf_add_highlight(buf, -1, 'WhidHeader', 0, 0, -1)
end

--local function createFloatingWindow()
    --bufh = vim.api.nvim_create_buf(false, true)
    --vim.api.nvim_buf_set_option(bufh, 'bufhidden', 'wipe')
    ----vim.api.nvim_buf_set_option(bufh, 'filetype', 'Vim-Kanban')

    --local stats = vim.api.nvim_list_uis()[1]
    --local width = stats.width
    --local height = stats.height

    --local dim_height = math.ceil(height*0.8 - 4)
    --local dim_width = math.ceil(width*0.8)

    --local row = math.ceil((height - dim_height) / 2 - 1)
    --local col = math.ceil((width - (dim_width*1.1)))

    ----local lb = math.ceil(dim_width/4) - 1
    --local lb = math.ceil(dim_width/3) - 1

    --local bufh_opts = {
        --style='minimal',
        --relative="editor",
        --width=width-3,
        --height=height-3,
        --col=col,
        --row=row,
    --}

    --local border_opts = {
        --style = "minimal",
        --relative = "editor",
        --width = dim_width + 2,
        --height = dim_height + 2,
        --row = row - 1,
        --col = col - 1
    --}

    --local border_buf = vim.api.nvim_create_buf(false, true)
    --local border_lines = { '╔' .. string.rep('═', dim_width) .. '╗' }
    --local linebreak = '║' .. string.rep(' ', lb) .. '|' .. string.rep(' ', lb) .. '|' .. string.rep(' ', lb) .. '║'
    ----local linebreak = '║' .. string.rep(' ', lb) .. '|' .. string.rep(' ', lb) .. '|' .. string.rep(' ', lb) .. '|' .. string.rep(' ', lb) .. '║'
    --for i=1, dim_height do
          --table.insert(border_lines, linebreak)
    --end

    --table.insert(border_lines, '╚' .. string.rep('═', dim_width) .. '╝')
    --vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

    --local border_win = vim.api.nvim_open_win(border_buf, true, border_opts)
    --win = vim.api.nvim_open_win(bufh, true, opts)

    --vim.api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
    --vim.api.nvim_buf_set_lines(bufh, 0, -1, false, {
        --center('Vim-Kanban Default', lb),
        --''
    --})
--end

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
