" MAPS: SUBJECT SPECIFIC
" INF_3910
nnoremap <leader>iu :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh u<cr>
" nnoremap <leader>iiu :Silent	/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh uu %<cr>
nnoremap <leader>iiu :call Upload()<cr>
nnoremap <leader>id :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh d<cr>
nnoremap <leader>iid :Silent	/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh dd %<cr>
nnoremap <leader>is :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh s<cr>
nnoremap <leader>ik :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh k<cr>

function! g:Upload()
	exec 'Silent /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh uu ' . expand('%:p')
endfunction
