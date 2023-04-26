-- Terminal emulator
local terminal = 'terminator'

-- Editor
local editor = os.getenv('EDITOR') or 'vim'


return {
    terminal = terminal,
    editor = editor,
}
