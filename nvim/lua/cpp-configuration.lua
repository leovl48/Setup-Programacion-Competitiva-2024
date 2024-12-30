vim.cmd("autocmd filetype cpp nnoremap <F8> :vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>")
vim.cmd("autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -DLOCAL -std=c++17 % -o %:r<CR>")
vim.cmd("autocmd filetype cpp nnoremap <F10> :vsp <CR> :term ./%:r <CR>")
