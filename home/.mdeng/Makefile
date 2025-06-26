# Deps

.PHONY: apt
apt:
	sudo apt-get -y update
	sudo apt-get -y install software-properties-common

.PHONY: apt-core
apt-core: | apt
	sudo apt-get -y install git curl wget xclip kitty zsh

~/.oh-my-zsh/oh-my-zsh.sh: | apt-core
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: snap-core
snap-core: | apt
	snap install yq

.PHONY: apt-misc
apt-misc: | apt
	sudo apt-get -y install bat ripgrep jq pandoc

~/.homesick/repos/homeshick: | apt-core
	git clone https://github.com/andsens/homeshick.git $$HOME/.homesick/repos/homeshick

~/.homesick/repos/midenrc: ~/.homesick/repos/homeshick
	$$HOME/.homesick/repos/homeshick/bin/homeshick clone https://github.com/michaelmdeng/midenrc.git

.PHONY: homeshick
homeshick: | ~/.homesick/repos/homeshick ~/.homesick/repos/midenrc ~/.oh-my-zsh/oh-my-zsh.sh
	$$HOME/.homesick/repos/homeshick/bin/homeshick link -f midenrc

# Python

.PHONY: system-python
system-python: | apt
	sudo apt-get -y install python3-dev python3-pip python3-virtualenv python3-virtualenvwrapper

~/.pyenv/bin: | apt-core
	sudo apt-get -y install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
~/.pyenv/plugins/pyenv-virtualenvwrapper: | ~/.pyenv/bin
	git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $$(~/.pyenv/bin/pyenv root)/plugins/pyenv-virtualenvwrapper
~/.pyenv/plugins/pyenv-virtualenv: | ~/.pyenv/bin
	git clone https://github.com/pyenv/pyenv-virtualenv.git $$(~/.pyenv/bin/pyenv root)/plugins/pyenv-virtualenv

~/.pyenv/versions/3.11.*: | ~/.pyenv/bin
	~/.pyenv/bin/pyenv install 3.11

~/.pyenv/versions/3.12.*: | ~/.pyenv/bin
	~/.pyenv/bin/pyenv install 3.12

.PHONY: pyenv-versions
pyenv-versions: | ~/.pyenv/versions/3.12.* ~/.pyenv/versions/3.11.*

.PHONY: python-dev
python-dev: | pyenv-versions system-python

# Neovim

.PHONY: apt-vim
apt-vim: | apt
	sudo apt-get -y install vim neovim python3-neovim

~/.virtualenvs/nvim3: | pyenv-versions
	mkvirtualenv --python=$$(~/.pyenv/bin/pyenv root)/versions/3.12.1/bin/python nvim3
	~/.virtualenvs/nvim3/bin/pip3 install sexpdata websocket-client

~/.vim/autoload/plug.vim: | apt-core
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

~/.fzf/install: | apt-core
	git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
	~/.fzf/install --no-update-rc --key-bindings --completion

.PHONY: nvim
nvim: | apt-vim ~/.virtualenvs/nvim3 ~/.fzf/install ~/.vim/autoload/plug.vim
	nvim -c PlugInstall -c UpdateRemotePlugins -c qa!

# Ruby

.PHONY: system-ruby
system-ruby: | apt
	sudo apt-get -y install ruby ruby-dev
	sudo gem install lefthook tmuxinator solargraph neovim

~/.rvm/bin: | apt-core
	sudo apt-get install gnupg2
	gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable
	~/.rvm/bin/rvm get stable
	~/.rvm/bin/rvm reload

~/.rvm/rubies/ruby-3.2.*: | ~/.rvm/bin
	~/.rvm/bin/rvm install 3.2.1

.PHONY: ruby-dev
ruby-dev: | system-ruby ~/.rvm/rubies/ruby-3.2.*


~/.tmux/plugins/tpm: | apt-core
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# .PHONY: tmux
# tmux: | ruby apt-core
# 	sudo apt-get install -y tmux
# 	sudo gem install tmuxinator mdl

# Java/Scala

# Golang

/usr/local/go/bin:
	echo "Install golang!"

.PHONY: go-dev
go-dev: | /usr/local/go/bin
	go install golang.org/x/tools/gopls@v0.15.2

all: | ruby-dev python-dev nvim
