" ~/.vimrc
"

" no vi compat
set nocompatible
set guifont=Inconsolata\ 12
set autowrite
colorscheme torte


" filetype func off
filetype off

" initialize vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" start- all plugins below

Plugin 'VundleVim/Vundle.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'chrisbra/csv.vim'
"put the cursor on line then do gS or gJ to put code on multiple lines or
"single line
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'vim-airline/vim-airline'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'vim-syntastic/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leshill/vim-json'
Plugin 'leafgarland/typescript-vim'
"errp<TAB> after err code, also fn<TAB> start typing variable in string 
"also json<TAB> in struct
"fn -> fmt.Println()
"ff -> fmt.Printf()
"ln -> log.Println()
"lf -> log.Printf()
Plugin 'SirVer/ultisnips'
" stop - all plugins above
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

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

