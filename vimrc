set nocompatible  "关闭与VI的兼容  
set number  "显示行号  
set noswapfile "no swap file"
set mouse=a  "use mouse"
set foldmethod=indent "method indent"
set clipboard=unnamed "copy from the pc"
let g:javascript_plugin_jsdoc = 1
filetype on   
set history=1000   
set background=dark "设置背景为灰色  
syntax on  "打开语法高亮显示  
set autoindent "自动对齐，使用上一行的对齐方式  
set smartindent "智能对齐方式  
set tabstop=2
set expandtab "永远使用空格代替tab"
set shiftwidth=2  
set showmatch  "设置匹配模式，类似当输入一个左括号时匹配上相应的那个右括号  
set guioptions-=T  
set vb t_vb=  
set ruler "在编辑过程中，在右下角显示光标位置的状态行  
set nohls    
set incsearch "搜索自动定位  
if has("vms")  
set nobackup  
else  
set encoding=utf-8
set backup  
endif  
syntax on
colorscheme molokai
set t_Co=256
set runtimepath^=~/.vim/bundle/ctrlp.vim
set novisualbell          "关掉可视化响铃警报
set noerrorbells          "关掉错误警报
set visualbell t_vb=      "关掉警报
filetype on                     " 开启文件类型检测
filetype plugin on              " 开启插件的支持
filetype indent on              " 开启文件类型相应的缩进规则
set smartcase
set ignorecase        			"搜索时忽略大小写"
set incsearch					"搜索时及时匹配搜索内容，需要回车确认
set hlsearch        			"高亮搜索项"
autocmd vimenter *NERDTree
execute pathogen#infect()
"------------------------------------------------------
"" Syntastic
"------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

 let g:syntastic_ruby_checkers = ['rubocop']

 let g:syntastic_error_symbol = 'x'
 let g:syntastic_style_error_symbol = 'x'
 let g:syntastic_warning_symbol = 'x'
 let g:syntastic_style_warning_symbol = 'x'

 highlight link SyntasticErrorSign SignColumn
 highlight link SyntasticWarningSign SignColumn
 highlight link SyntasticStyleErrorSign SignColumn
 highlight link SyntasticStyleWarningSign SignColum


"------------------------------------------------
"" NERDTree
"------------------------------------------------
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
