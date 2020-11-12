SHELL=/bin/bash

init:
	ln -vsf ${PWD}/.bashrc ${HOME}/.bashrc
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -vsf ${PWD}/.tigrc ${HOME}/.tigrc
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.alias ${HOME}/.tmux.alias
	ln -vsf ${PWD}/.bash_profile ${HOME}/.tmux.bash_profile

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
		php php-xdebug php-mysql php-curl php-xml \
		mysql-server \
		xclip \
		yui-compressor \
		nodejs \
		npm \
		tree \
		powerline \
		pv \
		ruby \
		ruby-dev \
		python3-pip
endif

goinstall: #Install GoLang
	@echo "Installing Goland"
	curl -fsSL https://golang.org/dl/go1.15.4.linux-amd64.tar.gz -o go1.15.4.linux-amd64.tar.gz
	tar -C /usr/local -xzf go1.15.4.linux-amd64.tar.gz

vim:
	cp -R ${PWD}/.vim ${HOME}/
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim