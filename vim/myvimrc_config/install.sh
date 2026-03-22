#!/bin/bash
install(){
    if [ ! -f ~/.vim ]; then
        mkdir ~/.vim
    fi
    if [ ! -f ~/.vim/undodir ]; then
        mkdir ~/.vim/undodir
    fi
    if [ ! -f ~/.vim/plugged ]; then
        mkdir ~/.vim/plugged
    fi
    # installing vim plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.old
    fi
    cp ./vimrc ~/.vimrc
    vim +PlugInstall +qall
}

install
