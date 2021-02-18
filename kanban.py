import pynvim

@pynvim.plugin
class KanbanPlugin(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.function("GreeterFunction")
    def greeter_function(self, args):
        self.nvim.current.line = "Hi -> From the test function"
