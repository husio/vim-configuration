" VimWiki plugin file
" Language:    Wiki
" Author:      Maxim Kim (habamax at gmail dot com)
" Home:        http://code.google.com/p/vimwiki/
" Filenames:   *.wiki
" Last Change: 2009-02-20 23:42
" Version:     0.7.0

if exists("g:loaded_vimwiki_html_auto") || &cp
  finish
endif
let g:loaded_vimwiki_html_auto = 1

" elements counter
let b:vimwiki_section_counter = 0
let b:vimwiki_section_class="cn"

function! s:section_counter_get()
    let b:vimwiki_section_counter += 1
    return b:vimwiki_section_counter
endfunction

function! s:section_attr_get()
    return ' class="'. b:vimwiki_section_class .'" id="'. s:section_counter_get() .'" '
endfunction

"" I do not want to redefine these functions. Really. I do not want them to be
"" global too.
function! s:msg(message) "{{{
  echohl WarningMsg
  echomsg 'vimwiki: '.a:message
  echohl None
endfunction "}}}

function! s:get_file_name_only(filename) "{{{
  let word = substitute(a:filename, '\'.g:vimwiki_ext, "", "g")
  let word = substitute(word, '.*[/\\]', "", "g")
  return word
endfunction "}}}

function! s:syntax_supported() " {{{
  return g:vimwiki_syntax == "default"
endfunction " }}}

function! s:create_default_CSS(path) " {{{
  if glob(a:path.'style.css') == ""
    let lines = ['body {margin: 1em 5em 1em 5em; font-size: 100%; line-height: 1.5;}']
    call add(lines, 'h1 {font-size: 2.0em;}')
    call add(lines, 'h2 {font-size: 1.4em;}')
    call add(lines, 'h3 {font-size: 1.0em;}')
    call add(lines, 'h4 {font-size: 0.8em;}')
    call add(lines, 'h5 {font-size: 0.7em;}')
    call add(lines, 'h6 {font-size: 0.6em;}')
    call add(lines, 'h1, h2, h3, h4, h5, h6 {margin: 1.2em auto 0.6em;}')
    call add(lines, 'h1 {border-bottom: 1px solid #3366cc; text-align: left; padding: 0em 1em 0em 0em;}')
    call add(lines, 'h3 {background: #e5ecf9; border-top: 1px solid #3366cc; padding: 0em 0.3em 0em 0.5em;}')
    call add(lines, 'p, ul, ol, pre {margin: 0.6em auto;}')
    call add(lines, 'ul {margin-left: 2em; padding-left: 0.5em;}')
    call add(lines, 'img {border: none;}')
    call add(lines, 'pre {border-left: 1px solid #ccc; margin-left: 2em; padding-left: 0.5em;}')
    call add(lines, 'td {border: 1px solid #ccc; padding: 0.3em;}')
    call add(lines, 'hr {border: none; border-top: 1px solid #ccc; width: 100%;}')
    call add(lines, '.todo {font-weight: bold; text-decoration: underline; color: #FF0000;}')
    call add(lines, '.strike {text-decoration: line-through;}')

    call writefile(lines, a:path.'style.css')
    echomsg "Default style.css is created."
  endif
endfunction "}}}

function! s:remove_blank_lines(lines) " {{{
  while a:lines[-1] =~ '^\s*$'
    call remove(a:lines, -1)
  endwhile
endfunction "}}}

function! s:is_web_link(lnk) "{{{
  if a:lnk =~ '^\(http://\|www.\|ftp://\)'
    return 1
  endif
  return 0
endfunction "}}}

function! s:is_img_link(lnk) "{{{
  if a:lnk =~ '\.\(png\|jpg\|gif\|jpeg\)$'
    return 1
  endif
  return 0
endfunction "}}}

function! s:is_non_wiki_link(lnk) "{{{
  if a:lnk =~ '.\+\..\+$'
    return 1
  endif
  return 0
endfunction "}}}

function! s:get_html_header(title, charset) "{{{
  let lines=[]

  " globals are bad, but...
  if g:vimwiki_html_header != ""
    try
      let lines = readfile(g:vimwiki_html_header)
      call map(lines, 'substitute(v:val, "%title%", "'. a:title .'", "g")')
      return lines
    catch /E484/
      call s:msg("Header template ". g:vimwiki_html_header. " does not exist!")
    endtry
  endif

  " if no g:vimwiki_html_header set up or error while reading template
  " file -- use default header.
  call add(lines, '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"')
  call add(lines, '    "http://www.w3.org/TR/html4/strict.dtd">')
  call add(lines, '<html>')
  call add(lines, '<head>')
  call add(lines, '<link rel="Stylesheet" type="text/css" href="style.css" />')
  call add(lines, '<title>'.a:title.'</title>')
  call add(lines, '<meta http-equiv="Content-Type" content="text/html; charset='.a:charset.'" />')
  call add(lines, '</head>')
  call add(lines, '<body>')

  return lines
endfunction "}}}

function! s:get_html_footer() "{{{
  let lines=[]

  " globals are bad, but...
  if g:vimwiki_html_footer != ""
    try
      let lines = readfile(g:vimwiki_html_footer)
      return lines
    catch /E484/
      call s:msg("Footer template ". g:vimwiki_html_footer. " does not exist!")
    endtry
  endif

  " if no g:vimwiki_html_footer set up or error while reading template
  " file -- use default footer.
  call add(lines, "")
  call add(lines, '</body>')
  call add(lines, '</html>')

  return lines
endfunction "}}}

function! s:close_tag_code(code, ldest) "{{{
  if a:code
    call insert(a:ldest, "</pre></code>")
    return 0
  endif
  return a:code
endfunction "}}}

function! s:close_tag_pre(pre, ldest) "{{{
  if a:pre
    call insert(a:ldest, "</pre>")
    return 0
  endif
  return a:pre
endfunction "}}}

function! s:close_tag_table(table, ldest) "{{{
  if a:table
    call insert(a:ldest, "</table>")
    return 0
  endif
  return a:table
endfunction "}}}

function! s:close_tag_list(lists, ldest) "{{{
  while len(a:lists)
    let item = remove(a:lists, -1)
    call insert(a:ldest, item[0])
  endwhile
endfunction! "}}}

function! s:process_tag_code(line, code) "{{{
  let lines = []
  let code = a:code
  let processed = 0
  if !code && a:line =~ '^{{{\s*$'
    let code = 1
    call add(lines, "<code><pre ". s:section_attr_get() .">")
    let processed = 1
  elseif code && a:line =~ '^}}}\s*$'
    let code = 0
    call add(lines, "</pre></code>")
    let processed = 1
  elseif code
    let processed = 1
    call add(lines, a:line)
  endif
  return [processed, lines, code]
endfunction "}}}

function! s:process_tag_pre(line, pre) "{{{
  let lines = []
  let pre = a:pre
  let processed = 0
  if a:line =~ '^\s\+[^[:blank:]*#]'
    if !pre
      call add(lines, "<pre". s:section_attr_get() .">")
      let pre = 1
    endif
    let processed = 1
    call add(lines, a:line)
  elseif pre && a:line =~ '^\s*$'
    let processed = 1
    call add(lines, a:line)
  elseif pre 
    call add(lines, "</pre>")
    let pre = 0
  endif
  return [processed, lines, pre]
endfunction "}}}

function! s:process_tag_list(line, lists) "{{{
  let lines = []
  let lstSym = ''
  let lstTagOpen = ''
  let lstTagClose = ''
  let lstRegExp = ''
  let processed = 0
  if a:line =~ '^\s\+\*'
    let lstSym = '*'
    let lstTagOpen = '<ul>'
    let lstTagClose = '</ul>'
    let lstRegExp = '^\s\+\*'
    let processed = 1
  elseif a:line =~ '^\s\+#' 
    let lstSym = '#'
    let lstTagOpen = '<ol>'
    let lstTagClose = '</ol>'
    let lstRegExp = '^\s\+#'
    let processed = 1
  endif
  if lstSym != ''
    let indent = stridx(a:line, lstSym)
    let cnt = len(a:lists)
    if !cnt || (cnt && indent > a:lists[-1][1])
      call add(a:lists, [lstTagClose, indent])
      call add(lines, lstTagOpen)
    elseif (cnt && indent < a:lists[-1][1])
      while indent < a:lists[-1][1]
        let item = remove(a:lists, -1)
        call add(lines, item[0])
      endwhile
    endif
    call add(lines, '<li>'.substitute(a:line, lstRegExp, '', '').'</li>')
  else
    while len(a:lists)
      let item = remove(a:lists, -1)
      call add(lines, item[0])
    endwhile
  endif
  return [processed, lines]
endfunction "}}}

function! s:process_tag_p(line) "{{{
  let lines = []
  if a:line =~ '^\S'
    call add(lines, '<p '. s:section_attr_get() .'>'.a:line.'</p>')
    return [1, lines]
  endif
  return [0, lines]
endfunction "}}}

function! s:process_tag_h(line) "{{{
  let line = a:line
  let processed = 0
  if a:line =~ '^!\{6}.*$'
    let line = '<h6 '. s:section_attr_get() .'>'.strpart(a:line, 6).'</h6>'
    let processed = 1
  elseif a:line =~ '^!\{5}.*$'
    let line = '<h5 '. s:section_attr_get() .'>'.strpart(a:line, 5).'</h5>'
    let processed = 1
  elseif a:line =~ '^!\{4}.*$'
    let line = '<h4 '. s:section_attr_get() .'>'.strpart(a:line, 4).'</h4>'
    let processed = 1
  elseif a:line =~ '^!\{3}.*$'
    let line = '<h3 '. s:section_attr_get() .'>'.strpart(a:line, 3).'</h3>'
    let processed = 1
  elseif a:line =~ '^!\{2}.*$'
    let line = '<h2 '. s:section_attr_get() .'>'.strpart(a:line, 2).'</h2>'
    let processed = 1
  elseif a:line =~ '^!\{1}.*$'
    let line = '<h1 '. s:section_attr_get() .'>'.strpart(a:line, 1).'</h1>'
    let processed = 1
  endif
  return [processed, line]
endfunction "}}}

function! s:process_tag_hr(line) "{{{
  let line = a:line
  let processed = 0
  if a:line =~ '^-----*$'
    let line = '<hr />'
    let processed = 1
  endif
  return [processed, line]
endfunction "}}}

function! s:process_tag_table(line, table) "{{{
  let table = a:table
  let lines = []
  let processed = 0
  if a:line =~ '^||.\+||.*'
    if !table
      call add(lines, "<table ". s:section_attr_get() .">")
      let table = 1
    endif
    let processed = 1

    call add(lines, "<tr>")
    let pos1 = 0
    let pos2 = 0
    let done = 0
    while !done
      let pos1 = stridx(a:line, '||', pos2)
      let pos2 = stridx(a:line, '||', pos1+2)
      if pos1==-1 || pos2==-1
        let done = 1
        let pos2 = len(a:line)
      endif
      let line = strpart(a:line, pos1+2, pos2-pos1-2)
      if line != ''
        call add(lines, "<td>".line."</td>")
      endif
    endwhile
    call add(lines, "</tr>")

  elseif table
    call add(lines, "</table>")
    let table = 0
  endif
  return [processed, lines, table]
endfunction "}}}

function! s:process_tags(line) "{{{
  let line = a:line
  let line = s:make_tag(line, '\[\[.\{-}\]\]', '', '', 2, 's:make_internal_link')
  let line = s:make_tag(line, '\[.\{-}\]', '', '', 1, 's:make_external_link')
  let line = s:make_tag(line, g:vimwiki_rxWeblink, '', '', 0, 's:make_barebone_link')
  let line = s:make_tag(line, g:vimwiki_rxWikiWord, '', '', 0, 's:make_wikiword_link')
  let line = s:make_tag(line, g:vimwiki_rxItalic, '<em>', '</em>')
  let line = s:make_tag(line, g:vimwiki_rxBold, '<strong>', '</strong>')
  let line = s:make_tag(line, g:vimwiki_rxTodo, '<span class="todo">', '</span>', 0)
  let line = s:make_tag(line, g:vimwiki_rxDelText, '<span class="strike">', '</span>', 2)
  let line = s:make_tag(line, g:vimwiki_rxSuperScript, '<sup><small>', '</small></sup>', 1)
  let line = s:make_tag(line, g:vimwiki_rxSubScript, '<sub><small>', '</small></sub>', 2)
  let line = s:make_tag(line, g:vimwiki_rxCode, '<code>', '</code>')
  " TODO: change make_tag function: delete cSym parameter -- count of symbols
  " to strip from 2 sides of tag. Add 2 new instead -- OpenWikiTag length
  " and CloseWikiTag length as for preformatted text there could be {{{,}}} and <pre>,</pre>.
  let line = s:make_tag(line, g:vimwiki_rxPreStart.'.\+'.g:vimwiki_rxPreEnd, '<code>', '</code>', 3)
  return line
endfunction " }}}

function! s:safe_html(line) "{{{
  "" change dangerous html symbols: < > &

  let line = substitute(a:line, '&', '\&amp;', 'g')
  let line = substitute(line, '<', '\&lt;', 'g')
  let line = substitute(line, '>', '\&gt;', 'g')
  return line
endfunction "}}}

function! s:make_tag_helper(line, regexp_match, tagOpen, tagClose, cSymRemove, func) " {{{
  "" Substitute text found by regexp_match with tagOpen.regexp_subst.tagClose

  let pos = 0
  let lines = split(a:line, a:regexp_match, 1)
  let res_line = ""
  for line in lines
    let res_line = res_line.line
    let matched = matchstr(a:line, a:regexp_match, pos)
    if matched != ""
      let toReplace = strpart(matched, a:cSymRemove, len(matched)-2*a:cSymRemove)
      if a:func!=""
        let toReplace = {a:func}(toReplace)
      else
        let toReplace = a:tagOpen.toReplace.a:tagClose
      endif
      let res_line = res_line.toReplace
    endif
    let pos = matchend(a:line, a:regexp_match, pos)
  endfor
  return res_line

endfunction " }}}

function! s:make_tag(line, regexp_match, tagOpen, tagClose, ...) " {{{
  "" Make tags only if not in ` ... `
  "" ... should be function that process regexp_match deeper.

  "check if additional function exists
  let func = ""
  let cSym = 1
  if a:0 == 2
    let cSym = a:1
    let func = a:2
  elseif a:0 == 1
    let cSym = a:1
  endif

  let patt_splitter = '\(`[^`]\+`\)\|\({{{.\+}}}\)\|\(<a href.\{-}</a>\)\|\(<img src.\{-}/>\)'
  if '`[^`]\+`' == a:regexp_match || '{{{.\+}}}' == a:regexp_match
    let res_line = s:make_tag_helper(a:line, a:regexp_match, a:tagOpen, a:tagClose, cSym, func)
  else
    let pos = 0
    " split line with patt_splitter to have parts of line before and after
    " href links, preformatted text
    " ie:
    " hello world `is just a` simple <a href="link.html">type of</a> prg.
    " result:
    " ['hello world ', ' simple ', 'type of', ' prg']
    let lines = split(a:line, patt_splitter, 1)
    let res_line = ""
    for line in lines
      let res_line = res_line.s:make_tag_helper(line, a:regexp_match, a:tagOpen, a:tagClose, cSym, func)
      let res_line = res_line.matchstr(a:line, patt_splitter, pos)
      let pos = matchend(a:line, patt_splitter, pos)
    endfor
  endif
  return res_line
endfunction " }}}

function! s:make_external_link(entag) "{{{
  "" Make <a href="link">link desc</a>
  "" from [link link desc]

  let line = ''
  if s:is_web_link(a:entag)
    let lnkElements = split(a:entag)
    let head = lnkElements[0]
    let rest = join(lnkElements[1:])
    if rest==""
      let rest=head
    endif
    if s:is_img_link(rest)
      if rest!=head
        let line = '<a href="'.head.'"><img src="'.rest.'" /></a>'
      else
        let line = '<img src="'.rest.'" />'
      endif
    else
      let line = '<a href="'.head.'">'.rest.'</a>'
    endif
  elseif s:is_img_link(a:entag)
    let line = '<img src="'.a:entag.'" />'
  else
    " [alskfj sfsf] shouldn't be a link. So return it as it was --
    " enclosed in [...]
    let line = '['.a:entag.']'
  endif
  return line
endfunction "}}}

function! s:make_internal_link(entag) "{{{
  "" Make <a href="This is a link">This is a link</a>
  "" from [[This is a link]]
  "" Make <a href="link">This is a link</a>
  "" from [[link|This is a link]]

  let line = ''
  let link_parts = split(a:entag, "|")
  if len(link_parts) > 1
    if s:is_img_link(link_parts[0])
      let line = '<img src="'.link_parts[0].'" alt="'.join(link_parts[1:], "|").'" />'
    elseif s:is_non_wiki_link(link_parts[0])
      let line = '<a href="'.link_parts[0].'">'.join(link_parts[1:], "|").'</a>'
    else
      let line = '<a href="'.link_parts[0].'.html">'.join(link_parts[1:], "|").'</a>'
    endif
  else
    if s:is_img_link(a:entag)
      let line = '<img src="'.a:entag.'" />'
    elseif s:is_non_wiki_link(a:entag)
      let line = '<a href="'.a:entag.'">'.a:entag.'</a>'
    else
      let line = '<a href="'.a:entag.'.html">'.a:entag.'</a>'
    endif
  endif
  return line
endfunction "}}}

function! s:make_wikiword_link(entag) "{{{
  "" Make <a href="WikiWord">WikiWord</a>
  "" from WikiWord
  let line = '<a href="'.a:entag.'.html">'.a:entag.'</a>'
  return line
endfunction "}}}

function! s:make_barebone_link(entag) "{{{
  "" Make <a href="http://habamax.ru">http://habamax.ru</a>
  "" from http://habamax.ru

  if s:is_img_link(a:entag)
    let line = '<img src="'.a:entag.'" />'
  else
    let line = '<a href="'.a:entag.'">'.a:entag.'</a>'
  endif
  return line
endfunction "}}}

function! s:get_html_from_wiki_line(line, pre, code, table, lists) " {{{
  let pre = a:pre
  let code = a:code
  let table = a:table
  let lists = a:lists

  let res_lines = []

  let line = s:safe_html(a:line)

  let processed = 0
  "" Code
  if !processed
    let [processed, lines, code] = s:process_tag_code(line, code)
    if processed && len(lists)
      call s:close_tag_list(lists, lines)
    endif
    if processed && table
      let table = s:close_tag_table(table, lines)
    endif
    if processed && pre
      let pre = s:close_tag_pre(pre, lines)
    endif
    call extend(res_lines, lines)
  endif

  "" Pre
  if !processed
    let [processed, lines, pre] = s:process_tag_pre(line, pre)
    if processed && len(lists)
      call s:close_tag_list(lists, lines)
    endif
    if processed && table
      let table = s:close_tag_table(table, lines)
    endif
    if processed && code
      let code = s:close_tag_code(code, lines)
    endif

    call extend(res_lines, lines)
  endif

  "" list
  if !processed
    let [processed, lines] = s:process_tag_list(line, lists)
    if processed && pre
      let pre = s:close_tag_pre(pre, lines)
    endif
    if processed && code
      let code = s:close_tag_code(code, lines)
    endif
    if processed && table
      let table = s:close_tag_table(table, lines)
    endif

    call map(lines, 's:process_tags(v:val)')

    call extend(res_lines, lines)
  endif

  "" table
  if !processed
    let [processed, lines, table] = s:process_tag_table(line, table)

    call map(lines, 's:process_tags(v:val)')

    call extend(res_lines, lines)
  endif

  if !processed
    let [processed, line] = s:process_tag_h(line)
    if processed
      call s:close_tag_list(lists, res_lines)
      let table = s:close_tag_table(table, res_lines)
      let code = s:close_tag_code(code, res_lines)
      call add(res_lines, line)
    endif
  endif

  if !processed
    let [processed, line] = s:process_tag_hr(line)
    if processed
      call s:close_tag_list(lists, res_lines)
      let table = s:close_tag_table(table, res_lines)
      let code = s:close_tag_code(code, res_lines)
      call add(res_lines, line)
    endif
  endif

  "" P
  if !processed
    let line = s:process_tags(line)

    let [processed, lines] = s:process_tag_p(line)
    if processed && pre
      let pre = s:close_tag_pre(pre, res_lines)
    endif
    if processed && code
      let code = s:close_tag_code(code, res_lines)
    endif
    if processed && table
      let table = s:close_tag_table(table, res_lines)
    endif
    call extend(res_lines, lines)
  endif

  "" add the rest
  if !processed
    call add(res_lines, line)
  endif

  return [res_lines, pre, code, table, lists]

endfunction " }}}

function! vimwiki_html#Wiki2HTML(path, wikifile) "{{{
  if !s:syntax_supported()
    call s:msg('Wiki2Html: Only vimwiki_default syntax supported!!!')
    return
  endif

  if !isdirectory(a:path)
    call s:msg('Please create '.a:path.' directory first!')
    return
  endif

  let lsource=readfile(a:wikifile)
  let ldest = s:get_html_header(s:get_file_name_only(a:wikifile), &encoding)

  let pre = 0
  let code = 0
  let table = 0
  let lists = []

  for line in lsource
    let oldpre = pre
    let [lines, pre, code, table, lists] = s:get_html_from_wiki_line(line,
          \ pre, code, table, lists)

    " A dirty hack: There could be a lot of empty strings before
    " s:process_tag_pre find out `pre` is over. So we should delete
    " them all. Think of the way to refactor it out.
    if (oldpre != pre) && ldest[-1] =~ '^\s*$'
      call s:remove_blank_lines(ldest)
    endif

    call extend(ldest, lines)
  endfor

  call s:remove_blank_lines(ldest)

  "" process end of file
  "" close opened tags if any
  let lines = []
  call s:close_tag_pre(pre, lines)
  call s:close_tag_code(code, lines)
  call s:close_tag_list(lists, lines)
  call s:close_tag_table(table, lines)
  call extend(ldest, lines)

  call extend(ldest, s:get_html_footer())

  "" make html file.
  let wwFileNameOnly = s:get_file_name_only(a:wikifile)
  call writefile(ldest, a:path.wwFileNameOnly.'.html')
endfunction "}}}

function! vimwiki_html#WikiAll2HTML(path) "{{{
  if !s:syntax_supported()
    call s:msg('Wiki2Html: Only vimwiki_default syntax supported!!!')
    return
  endif

  if !isdirectory(a:path)
    call s:msg('Please create '.a:path.' directory first!')
    return
  endif

  let setting_more = &more
  setlocal nomore

  let wikifiles = split(glob(g:vimwiki_home.'*'.g:vimwiki_ext), '\n')
  for wikifile in wikifiles
    echomsg 'Processing '.wikifile
    call vimwiki_html#Wiki2HTML(a:path, wikifile)
  endfor
  call s:create_default_CSS(g:vimwiki_home_html)
  echomsg 'Done!'

  let &more = setting_more
endfunction "}}}
