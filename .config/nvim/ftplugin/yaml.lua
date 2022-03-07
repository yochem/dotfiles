vim.keymap.set('n', '<Left>', require('jvim').to_parent, {noremap = true})
vim.keymap.set('n', '<Right>', require('jvim').descend, {noremap = true})
vim.keymap.set('n', '<Up>', require('jvim').prev_sibling, {noremap = true})
vim.keymap.set('n', '<Down>', require('jvim').next_sibling, {noremap = true})
