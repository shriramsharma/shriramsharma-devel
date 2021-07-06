SHELL=/bin/bash

init:
	ln -vsf ${PWD}/.bashrc ${HOME}/.bashrc
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -vsf ${PWD}/.tigrc ${HOME}/.tigrc
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.alias ${HOME}/.tmux.alias
	ln -vsf ${PWD}/.bash_profile ${HOME}/.tmux.bash_profile

all: install-packages

install-packages:
ifeq ($(UNAME),Darwin)
	@echo "Darwin detected"
	brew install \
		vim \
		git \
		tig \
		tmux \
		zsh \
		curl \
		homebrew/php/php70 \
		yuicompressor \
		nodejs \
		npm \
		ack \
		reattach-to-user-namespace \
		wget \
		coreutils \
		htop
else
	@echo "Linux detected"
	sudo apt update
	sudo apt install -y \
		vim-gtk3 \
		wget \
		git \
		tig \
		tmux \
		zsh \
		curl \
		tree \
		xclip \
		powerline \
		ruby-dev \
		python3-pip
endif

powerline-fonts:
	git clone https://github.com/powerline/fonts.git --depth=1
	cd 	fonts && sh /install.sh

goinstall: #Install GoLang
	@echo "Installing Goland"
	curl -fsSL https://golang.org/dl/go1.15.4.linux-amd64.tar.gz -o /tmp/go1.15.4.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf /tmp/go1.15.4.linux-amd64.tar.gz

vim:
	cp -R ${PWD}/.vim ${HOME}/
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

.PHONY: all goinstall vim tpm