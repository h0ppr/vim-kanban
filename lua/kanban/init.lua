local function createFloatingWindow()
    local width = vim.fn.nvim_win_get_width(0)
    local height = vim.fn.nvim_win_get_height(0)

    local bufh = vim.api.nvim_create_buf(false, true)
    local winId = vim.api.nvim_open_win(bufh, true, {
        relative="editor",
        width=width-10,
        height=height-10,
        col=2,
        row=2,
    })
end

return {
    createFloatingWindow = createFloatingWindow
}
