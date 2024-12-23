local map = vim.keymap.set

-- <leader>action uses system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+Y]], { remap = true })

map({ "n", "v" }, "<leader>d", [["+d]])
map({ "n", "v" }, "<leader>D", [["+D]])

map({ "n", "v" }, "<leader>p", [["+p]])
map({ "n", "v" }, "<leader>P", [["+P]])

-- change line with commented previous version as backup
map("n", "yc", "yygccp", { remap = true })
map("v", "yc", "ygvgcP", { remap = true })

-- discard uninteresting text
map({ "n", "v" }, "c", '"_c')
map("n", "dd", [[getline(".") == "" ? '"_dd' : 'dd']], { expr = true })
