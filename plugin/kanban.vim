fun! Kanban()
    lua for k in pairs(package.loaded) do if k:match("^kanban") then package.loaded[k] = nil end end
    lua require("kanban").createFloatingWindow()
endfun

augroup Kanban
    autocmd!
    autocmd VimResized * :lua require("kanban").onResize()
augroup END
