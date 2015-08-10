#As a bare minimum, we need ruby and git.
need=""

if [ "$(which ruby)" == "" ]; then
	need="ruby"
	if [ "$(which git)" == "" ]; then
		need=$need" git"
elif [ "$(which git)" == "" ]; then
	need="git"
fi

if [ "$need" != "" ]; then
	echo "Unable to install Linuxbrew without $need."
	echo "Please ask your system administrator to install $need before continuing."
	kill -INT $$
fi

if [ ! -e "$HOME/.linuxbrew" ]; then
	if [ "$(which curl)" != "" ]; then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
	else
		git clone "https://github.com/Homebrew/linuxbrew.git" "~/.linuxbrew"
	fi
fi
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/append_paths.sh")
export PATH=$HOME/.linuxbrew/bin:$PATH
brew tap homebrew/dupes

[ "$(which curl)" == "" ] && brew install curl
[ "$(which bzip2)" == "" ] && brew install "bzip2"
[ "$(which zlib)" == "" ] && brew install zlib
[ "$(which m4)" == "" ] && brew install m4
[ "$(which texinfo)" == "" ] && brew install texinfo
[ "$(which expat)" == "" ] && brew install expat
[ "$(which ncurses)" == "" ] && brew install ncurses
[ "$(which gcc)" == "" ] && brew install "gcc"
[ "$(which gfortran)" == "" ] && brew install "gcc" #For ease of use with WRF.
