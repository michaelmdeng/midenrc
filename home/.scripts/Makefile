apt:
	sudo apt-get -y update
	sudo apt-get -y install software-properties-common

apt-git: apt
	sudo apt-get -y install git

apt-vim: apt
	sudo apt-get -y install vim neovim
	sudo apt-get -y install python3-neovim

apt-misc: apt
	sudo apt-get -y install bat ripgrep jq pandoc taskwarrior

homeshick:
	git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
	$HOME/.homesick/repos/homeshick/bin/homeshick clone https://github.com/michaelmdeng/midenrc.git
	$HOME/.homesick/repos/homeshick/bin/homeshick link -f midenrc

python: apt
	sudo apt-get -y install python3-dev python3-pip
	pip3 install --upgrade pip

pyenv: python apt-git
	sudo apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
	git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
	pyenv install 3.7.6
	pyenv install 3.8.1

virtualenv: python
	pip3 install virtualenv virtualenvwrapper

vim: apt-vim pyenv virtualenv ruby
	pip install sexpdata websocket-client
	gem install neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkvirtualenv --python=python3.8 nvim3
	workon nvim3
	pip3 install --upgrade pip
	pip3 install sexpdata websocket-client
	nvim -E -c UpdateRemotePlugins -c PlugInstall -c q
	deactivate

ruby: apt
	sudo apt-get -y install ruby ruby-dev

rvm: ruby
	sudo apt-add-repository -y ppa:rael-gc/rvm
	sudo apt-get -y update
	sudo apt-get -y install rvm
	rvm install ruby-2.6
	rvm install ruby-2.7

python-dev: vim pyenv virtualenv
	pyenv exec pip3 install pylint black pyls
	workon nvim3
	pip3 install pylint black pyls
	deactivate

ruby-dev: rvm
	sudo gem install solargraph
	rvm all do gem install solargraph

tmux: ruby apt-git
	sudo apt-get install -y tmux
	sudo gem install tmuxinator mdl
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
