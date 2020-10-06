function! g:Plugin_ale()
	" Tell ALE to use OmniSharp for linting C# files, and no other linters.
	let g:ale_linters = { 'cs': ['OmniSharp'] }
endfunction
