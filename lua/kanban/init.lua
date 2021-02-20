local function createFloatingWindow()
    local stats = vim.api.nvim_list_uis()[1]
    local width = stats.width
    local height = stats.height

    local bufh = vim.api.nvim_create_buf(false, true)
    local winId = vim.api.nvim_open_win(bufh, true, {
        relative="editor",
        width=width-3,
        height=height-3,
        col=2,
        row=2,
    })
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
