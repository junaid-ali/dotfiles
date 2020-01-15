insert_ifnotfound() {
  grep "${1}" "${2}" > /dev/null 2>&1
  [[ $? != 0 ]] && echo -e "${1}" >> "${2}"
}

# Changing the PWD to this script directory
cd "$( dirname "${BASH_SOURCE[0]}")"
mkdir -p ~/.dotfiles
cp -rf * ~/.dotfiles/

insert_ifnotfound "source ~/.dotfiles/linux/bashrc/bashrc" ~/.bashrc
insert_ifnotfound "source ~/.dotfiles/git-prompt.sh" ~/.bashrc

mkdir -p ~/.vim/colors
cp linux/vim/colors/* ~/.vim/colors/
insert_ifnotfound "$(cat linux/vim/vimrc)" ~/.vimrc

echo -e "Please run the following command for the changes to take effect in your current shell:
$ source ~/.bashrc"
