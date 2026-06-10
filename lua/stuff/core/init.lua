require('stuff.core.options')
require("stuff.core.keymaps")

vim.api.nvim_create_autocmd({"BufEnter"}, {
	pattern = "term://*",
	callback = function(ev)
		vim.opt_local.number = false
		vim.opt_local.cmdheight = 0
--		vim.opt.showmode = false
		vim.schedule(function()
			vim.api.nvim_input("i")
			vim.opt_local.laststatus = 0
			vim.opt_local.number = false
			vim.opt_local.cmdheight = 0
		end)
	end
})
