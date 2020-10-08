fun! s:plugin()
	" Tell ALE to use OmniSharp for linting C# files, and no other linters.
	let g:ale_linters = { 'cs': ['OmniSharp'] }
endfun
call s:plugin()
