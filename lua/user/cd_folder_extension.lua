local M = {}
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')
local actions_set = require('telescope.actions.set')
local from_entry = require('telescope.from_entry')


local cdPicker = function(name, cmd)
    pickers.new({}, {
        prompt_title = name,
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local dir = from_entry.path(entry)
                print("hello" .. dir)
                vim.cmd('cd '..dir)
            end)
            return true
        end,
    }):find()
end

function M.Cd(path)
    path = path or '.'
    cdPicker('Cd', {vim.o.shell, '-c', "fd . "..path.." -d 1 --type=d 2>/dev/null"})
end

function M.Cdz()
  cdPicker('z directories', {vim.o.shell, '-c', "fd . ~/.config --type=d 2>/dev/null"})
end
return M
