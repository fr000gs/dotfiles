{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #(let
    #  copilot = pkgs.vimUtils.buildVimPlugin {
    #    name = "";
    #    src = pkgs.fetchFromGitHub {
    #      owner = "dstein64";
    #      repo = "nvim-scrollview";
    #      rev = "095181bc2adb64af670dae73208871a731f0bb86";
    #      hash = "sha256-Y0VG+X16yB8gj+g/dCg2OUe1iXc0wGq94jGc3V/Lz7k=";
    #    };
    #  };
    #in
    #(
      ((vim-full.override{}).customize {
       #name = "vim";
       #Install plugins
       vimrcConfig = {
         packages.myplugins = with pkgs.vimPlugins; {
           start = [
             YouCompleteMe
             nerdtree
             vim-polyglot
             nvim-scrollview
             vim-wayland-clipboard
           ];
           opt = [];
         };
         customRC = ''
              set nocompatible
              set encoding=utf-8

              "call plug#begin()
              " The default plugin directory will be as follows:
              "   - Vim (Linux/macOS): '~/.vim/plugged'
              "   - Vim (Windows): '~/vimfiles/plugged'
              "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
              " You can specify a custom plugin directory by passing it as the argument
              "   - e.g. `call plug#begin('~/.vim/plugged')`
              "   - Avoid using standard Vim directory names like 'plugin'

              " Make sure you use single quotes
              autocmd TextYankPost * if (v:event.operator == 'y' || v:event.operator == 'd') | silent! execute 'call system("wl-copy", @")' | endif
           nnoremap p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', ''', 'g')<cr>p

           "Plug 'preservim/nerdtree'
           "Plug 'ycm-core/YouCompleteMe'
           " Initialize plugin system
           " - Automatically executes `filetype plugin indent on` and `syntax enable`.
           "call plug#end()

           colorscheme zaibatsu
           syntax enable

           set tabstop=4
           set softtabstop=4
           set expandtab

           set number
           set cursorline
           set mouse=a
           filetype plugin indent on
           set wildmenu
           set lazyredraw
           set showmatch

           set incsearch
           set foldenable
           set foldlevelstart=10
           nnoremap <space> za
           set foldmethod=syntax

           " Clear status line when vimrc is reloaded.
           set statusline=
             set statusline+=\ %F\ %M\ %Y\ %R
             set statusline+=%=
               set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
               set laststatus=2

               nnoremap j gj
               nnoremap k gk
               nnoremap <Up> gk
               nnoremap <Down> gj

               nnoremap <C-Up> <C-w>k
               nnoremap <C-Down> <C-w>j
               nnoremap <C-Left> <C-w>h
               nnoremap <C-Right> <C-w>l

               nnoremap <leader>t :tabnew<CR>
               nnoremap <leader>Left :tabp<CR>
               nnoremap <leader>Right :tabN<CR>
               nnoremap <leader>ev :vsp $MYVIMRC<CR>
               nnoremap <leader>ez :vsp ~/.zshrc<CR>
               nnoremap <leader>sv :source $MYVIMRC<CR>

               " Start NERDTree and put the cursor back in the other window.
               "autocmd VimEnter * NERDTree | wincmd p

               " Exit Vim if NERDTree is the only window remaining in the only tab.
               "autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

               " Close the tab if NERDTree is the only window remaining in it.
               "autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

               " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
               "autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
               \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

               " Open the existing NERDTree on each new tab.
               "autocmd BufWinEnter * if getcmdwintype() == ' ' | silent NERDTreeMirror | endif

               "set backup
               "set backupdir=/tmp/vim-tmp
               ""set backupskip=/tmp/*,/private/tmp/*
               "set directory=/tmp/vim-tmp
               "set writebackup
               '';
               };
               }
               )
    #)
    ];
    }

