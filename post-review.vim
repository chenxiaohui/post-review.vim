"=============================================================================
"     FileName: post-review.vim
"         Desc: Create post-review command 
"        Usage: nmap <leader>da  :call SvnAdd()<cr>
"               svndiff use vimdiff: see http://www.ccvita.com/445.html
"               gitdiff use vimdiff: see http://cxh.me/2013/09/14/show-gitdiff-using-vimdiff/
"       Author: ChenXiaohui
"        Email: sdqxcxh@gmail.com
"     HomePage: http://www.cxh.me
"      Version: 0.0.1
"   LastChange: 2013-09-17 10:10:55
"      History: 
"=============================================================================
if !exists('g:base_dir_mark')
  "set base_dir_mark to indicate where to generate post-review.sh
  let g:base_dir_mark = 'cscope.out'
endif
if !exists('g:chmod_after_create')
  "set base_dir_mark to 1 to chmod +x post-review.sh after created
  let g:chmod_after_create = 0
endif

function! FindBaseDir(filename)
    let max = 5
    let dir = './' 
    let i = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . a:filename) 
						return dir
        endif

        let dir = dir . '../'
        let i = i + 1
    endwhile
    return ''
endf

function! AppendFile(file_name, content)
  if filereadable(a:file_name)
    let file_content = readfile(a:file_name)
    if index(file_content, a:content) == -1
      call writefile(file_content + [a:content], a:file_name)
      echo "Add ".a:content." successfully."
    else 
      echo a:content." already exists."
    endif
  endif
endf

function! GetReviewId(file_name)
  if !filereadable(a:file_name) || empty(readfile(a:file_name))
    let version_id = input("Input your review id (empty to start a new review): ")
    let version_str = ''
    if !empty(version_id)
      let version_str = '-r '.version_id 
    endif
    
    call writefile(['#!/bin/bash','post-review '.version_str.' \'], a:file_name)
    if g:chmod_after_create
      silent execute '!chmod +x '.a:file_name 
    endif
    echo 'create post-review '.version_id.'successfully.'
  endif
endf

function! PostReview()
  let base_dir = FindBaseDir(g:base_dir_mark)
  let script_name = base_dir . 'post-review.sh'
  call GetReviewId(script_name)
  call AppendFile(script_name, expand("%:p").'\')
endf
