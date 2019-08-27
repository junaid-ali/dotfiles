insert_ifnotfound() {
  grep "${1}" "${2}" > /dev/null 2>&1
  [[ $? != 0 ]] && echo -e "${1}" >> "${2}"
}

insert_ifnotfound "source ~/.dotfiles/linux/bashrc/bashrc" ~/.bashrc
insert_ifnotfound "source ~/.dotfiles/git-prompt.sh" ~/.bashrc

mkdir -p ~/.vim/colors
cp linux/vim/colors/* ~/.vim/colors/
insert_ifnotfound "$(cat linux/vim/vimrc)" ~/.vimrc
