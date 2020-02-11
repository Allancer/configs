# configs
my configs and reminders for new instalations

### i3 config needs:
  - URxvt
  - nitrogen
  
### zsh:
  - oh my zsh
    - zsh-syntax-highlighting ( git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting )

### vim:
  - pathogen (  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim )
    - lighline ( git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim )
      - colorscheme gotham ( https://github.com/whatyouhide/vim-gotham/blob/master/autoload/lightline/colorscheme/gotham.vim )
    
  - colorscheme gotham ( https://github.com/whatyouhide/vim-gotham/blob/master/colors/gotham.vim )
  - colorscheme gruvbox ( https://github.com/morhetz/gruvbox )
    - let g:gruvbox_contrast_dark='hard'
      colorscheme gruvbox
      set background=dark
      
      in bashrc or zshrc add -> source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
 
 ### htb ip
  - if using xfce4 + i3 use genmod plugin and modify htb script by adding <txt> </txt> in the last line
  
 ### Xfce4 + i3
  - comment i3 status bar out of the config
