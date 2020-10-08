fun! s:plugin()
	function! g:SyntaxLang(filetype, bool='enable') abort
		let l:ft = &ft
		if l:ft == a:filetype
			return
		endif

		let l:wrap = ''
		let l:cpre = '```'
		let l:pre = ''
		let l:post = '$'
		let l:sep = ''
		let l:match_group = 'NonText'
		let l:cmnt_set = 'y'

		let l:cmnt = g:CommenterGetCommentList()

		let l:cmnt[0] = substitute(l:cmnt[0], '\\', '', 'g')
		let l:cmnt[1] = substitute(l:cmnt[1], '\\', '', 'g')
		let l:cmnt[0] = substitute(l:cmnt[0], '''', '\\''', 'g')
		let l:cmnt[1] = substitute(l:cmnt[1], '''', '\\''', 'g')

		if l:cmnt[1] != ''
			let l:cmnt[1] = ' ' . l:cmnt[1]
		endif
		let l:cmnt[0] = l:cmnt[0] . ' '
		if l:cmnt_set == 'n'
			let l:cmnt[0] = ''
			let l:cmnt[1] = ''
		endif

		let l:pre =	l:cmnt[0] . l:wrap . l:pre	. l:sep . l:cpre . a:filetype . l:wrap . l:cmnt[1]
		let l:post =l:cmnt[0] . l:wrap . l:post	. l:sep . l:cpre . a:filetype . l:wrap . l:cmnt[1]

		if a:bool == 'enable'
			let l:cmd = "call SyntaxRange#Include('" . l:pre . "', '" . l:post . "', '" . a:filetype . "', '" . l:match_group . "')"
		else
			let l:cmd = "call SyntaxRange#IncludeEx('start=\"" . l:pre . "\" end=\"" . l:post . "\"', '" . a:filetype . "')"
		endif

		" echo l:cmd
		exec l:cmd
	endfunction

	function! s:_TextEnableCodeSnipAll()
		let l:langs = g:CommenterGetLanguages()
		for l:lang in l:langs
			call g:SyntaxLang(l:lang, 'enable')
		endfor
	endfunction

	" au VimEnter * call s:_TextEnableCodeSnipAll()
endfun
call s:plugin()
