vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.showcmd = true
--vim.opt.cursorline = true

vim.api.nvim_set_keymap('v', '<C-c>', [[:w !clip.exe<CR><CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-y>', [[:%w !clip.exe<CR><CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', [[f{V%zf]], { noremap = true, silent = true })

vim.g.coc_node_path = "/home/leovl48/.nvm/versions/node/v20.18.1/bin/node"

vim.opt.foldmethod = "manual"

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if vim.fn.bufname("%") ~= "" then
			vim.cmd("mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.bufname("%") ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

