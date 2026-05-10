local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

--Directions
local D = {up="k", down="l", left="j", right=";"}

--Controls
local C = {
    up="<A-" .. D.up .. ">",
    down="<A-" .. D.down .. ">",
    left="<A-" .. D.left .. ">",
    right="<A-" .. D.right .. ">",
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--keymap({"n"}, "<leader>st", ":set spell!<Enter>")
--keymap({"n"}, "<leader>su", "z=")
--keymap({"n"}, "<leader>sf", "]s")
--keymap({"n"}, "<leader>sb", "[s")

keymap({"n"}, "<Esc>", ":nohl<Enter>", opts) -- turn off highlight by Esc

vim.api.nvim_create_autocmd("TextYankPost", { -- highlight line when yank
	callback = function()
		vim.highlight.on_yank()
	end,
})

local quotes = {"'", '"'}
	for _,i in ipairs(quotes) do
		keymap("v", string.format("<leader>%s", i), string.format("c%s%s<Esc>P", i, i), opts)
end

--keymap({"n"}, "<A-e-c>", ':w<Enter>:!gcc % -o %:r && ./%:r<Enter>') --example to compile and execute C code

keymap({"n", "v", "x", "o"}, D.left, "h", opts)
keymap({"n", "v", "x", "o"}, D.up, "k", opts)
keymap({"n", "v", "x", "o"}, D.down, "j", opts)
keymap({"n", "v", "x", "o"}, D.right, "l", opts)

keymap({"n", "i", "v", "x", "o"}, "<A-k>", "<Esc>", opts)
keymap({"n", "i", "v", "x", "o"}, "<A-BS>", "<delete>", opts) -- (Alt+BackSpace)

keymap({"n", "v", "x", "o"}, C.left, "0", opts) --move the cursor to the start of a line
keymap({"n", "v", "x", "o"}, C.right, "$", opts) --move the cursor to the end of a line
--keymap({"n", "v", "x", "o"}, C.up, "gg", opts) --move the cursor to the start of a file
--keymap({"n", "v", "x", "o"}, C.down, "G", opts) --move the cursor to the end of a file

keymap({"n", "v", "x", "o"}, "<leader>d", '"_d', opts) --delete selection without copying to register
keymap({"n"}, "<leader>a", ':split | terminal<CR>', opts) -- "CR" is "Enter"

keymap({"v"}, "<C-"..D.down..">", ":m '>+1<Enter>gv=gv", opts) --move line down
keymap({"v"}, "<C-"..D.up..">", ":m '<-2<Enter>gv=gv", opts) --move line up
keymap({"v"}, "<C-"..D.left..">", '<gv', opts) --move line left
keymap({"v"}, "<C-"..D.right..">", '>gv', opts) --move line right

--[[local parantheses = {"[]", "()", "{}", "<>"}
for _,i in ipairs(parantheses) do
	keymap({"i"}, string.sub(i, 1, 1), string.format("%s<Esc>i", i), opts)
end ]]

--[[vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile'}, {
	pattern = '*.c',
	callback = function()
		vim.keymap.set('i', '(', '() {<Esc><Left><Left>i', opts)
	end,
}) ]]

keymap('n', "<leader>f", vim.lsp.buf.format) --mb i don't need this but anyway

keymap('n', "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) --Replace word cursor is on globally

keymap('n', "<leader>sv", "<C-w>v") --split window vertically
keymap('n', "<leader>se", "<C-w>=") --make split windows equal width & height
keymap('n', "<leader>sh", "<C-w>s") --split window horizotally
keymap('n', "<leader>sx", "<cmd>close<CR>") --close current split

keymap('n', "q", ":q<Enter>", opts)
keymap('n', "Q", ":q!<Enter>", opts)
keymap('n', "w", ":w<Enter>", opts)
keymap('n', "e", ":Ex<Enter>", opts)

local signs = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN] = " ",
    [vim.diagnostic.severity.HINT] = "󰠠 ",
    [vim.diagnostic.severity.INFO] = " ",
}

local function hide_diagnostics()
    vim.diagnostic.config({  -- https://neovim.io/doc/user/diagnostic.html
        virtual_text = false,
        signs = false,
        underline = false,
		virtual_lines = false,
        float = false,
    })
    require('cmp').setup { enabled = false }
    --print("Diagnostic turned off")
end
local function show_diagnostics()
    vim.diagnostic.config({
        signs = { text = signs },
        virtual_text = true,
        underline = true,
        --update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = true,
        },
    })
    require('cmp').setup { enabled = true }
    --print("Diagnostic turned on")
end
vim.keymap.set("n", "<leader>dh", hide_diagnostics, opts)
vim.keymap.set("n", "<leader>ds", show_diagnostics, opts)

--hide_diagnostics()
