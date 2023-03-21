-- Terminal emulator
local terminal = 'terminator'

-- Editor
local editor = os.getenv('EDITOR') or 'vim'
-- Editor command
local editor_cmd = terminal .. ' -e "' .. editor

return {
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd,
}
