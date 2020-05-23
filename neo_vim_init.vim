" ~/.vimrc
"

" no vi compat
set nocompatible
set guifont=Inconsolata\ 18
set autowrite
colorscheme torte


" filetype func off
filetype off

" initialize vundle
"set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin('~/.vim/plugged')
" start- all plugins below

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'chrisbra/csv.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'jeetsukumaran/vim-buffergator'
"Plug 'vim-syntastic/syntastic'
Plug 'sbdchd/neoformat'
Plug 'leshill/vim-json'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/indentpython.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ocaml/vim-ocaml'
Plug 'ajh17/VimCompletesMe' 
call plug#end()

" filetype func on
filetype plugin indent on
"goland defaults
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_snippet_case_type = "camelcase"
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"let g:go_metalinter_deadline = "5s"
let g:go_def_mode = 'godef'
"shows :GoInfo whereever the cursor moves to
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

"flow for javascript
let g:javascript_plugin_flow = 1
"for jsx files
let g:jsx_ext_required = 0

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']
let g:ocaml_highlight_operators = 1
" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

"shortcuts for golang
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"quickfix close \a
nnoremap <leader>a :cclose<CR> 
"autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
"autocmd FileType go nmap <leader>t  <Plug>(go-test)

let g:go_version_warning = 0
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

"javascipt indentation
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
"javascipt indentation
autocmd Filetype typescript setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2


"tabbing
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
"opens alternate file
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"same and splits vertical
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
":GoInfo show function information
autocmd FileType go nmap <Leader>i <Plug>(go-info)
"notes for Golang 
"CTRL-] go to defintion, CTRL-t jump back
":GoDefStack - shows history of jumps
"jump between functions ]] and [[
":GoDecls - shows declarations in other window
":GoDeclsDir - shows declarations in the directory
":GoDoc - put this on function and it shows some documentation
":GoSameIds - put cursor on function. it highlights all other place of it
":GoReferrers returns references to selected identifier	
":GoDescribe similar to above but more detail

"autocmd FileType ocaml source /home/febe/.opam/default/share/ocp-indent/ocp-indent.vim
"autocmd FileType ocaml source /home/febe/.opam/default/share/ocp-indent/vim/indent/ocaml.vim

"""au BufEnter *.ml setf ocaml
	"""aau BufEnter *.mli setf ocaml
	"""aau FileType ocaml call FT_ocaml()
	"""afunction FT_ocaml()
	  """a  set textwidth=80
	   """a set colorcolumn=80
	   """a set shiftwidth=2
	   """a set tabstop=2
	   " ocp-indent with ocp-indent-vim
	 """a   let opamshare=system("opam config var share | tr -d '\n'")
	"""a    execute "autocmd FileType ocaml source".opamshare."/ocp-indent/vim/indent/ocaml.vim"
	 """a   filetype indent on
	  """a  filetype plugin indent on
	"""aendfunction

filetype plugin indent on
syntax enable

" Vim needs to be built with Python scripting support, and must be
" able to find Merlin's executable on PATH.
if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/merlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif

" Your vimrc
autocmd FileType ocaml execute "set rtp+=" . substitute(system('opam config var share'), '\n$', '', '''') . "/ocp-indent/vim/indent/ocaml.vim"

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let g:ale_set_highlights = 0

function! s:termclose() abort
  let buf = expand('#')
  if !empty(buf) && buflisted(buf) && bufnr(buf) != bufnr('%')
    execute 'autocmd BufWinLeave <buffer> split' buf
  endif
endfunction

autocmd TermClose *:$SHELL,*:\$SHELL call s:termclose()
" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
