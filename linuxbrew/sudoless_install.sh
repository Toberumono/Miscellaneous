#!/usr/bin/env bash
#Installs Linuxbrew without using sudo (if possible)
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget -qO -"

if [ "$(which brew)" != "" ]; then
	echo "Linuxbrew is already installed."
	exit 0
fi

#As a bare minimum, we need ruby, git, and curl.
need=""
if [ "$(which ruby)" == "" ]; then
	need="ruby"
	if [ "$(which git)" == "" ]; then
		need=$need" git"
		if [ "$(which curl)" == "" ]; then
			need=$need" curl"
		fi
	elif [ "$(which curl)" == "" ]; then
		need=$need" curl"
	fi
elif [ "$(which git)" == "" ]; then
	need="git"
	if [ "$(which curl)" == "" ]; then
		need=$need" curl"
	fi
elif [ "$(which curl)" == "" ]; then
	need=$need"curl"
fi

if [ "$need" != "" ]; then
	echo "Unable to install Linuxbrew without $need."
	echo "Please ask your system administrator to install $need before continuing."
	exit 1
fi

if [ "$(which brew)" == "" ]; then
	if [ "$(which curl)" != "" ]; then
		ruby -e "$(curl -#fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
	else
		git clone "https://github.com/Homebrew/linuxbrew.git" "$HOME/.linuxbrew"
	fi
fi
bash <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/append_paths.sh")
export PATH=$HOME/.linuxbrew/bin:$PATH
brew tap homebrew/dupes

[ "$(which curl)" == "" ] && brew install curl
[ "$(which bzip2)" == "" ] && brew install "bzip2"
[ "$(which zlib)" == "" ] && brew install zlib
[ "$(which m4)" == "" ] && brew install m4
[ "$(which texinfo)" == "" ] && brew install texinfo
[ "$(which expat)" == "" ] && brew install expat
[ "$(which ncurses)" == "" ] && brew install ncurses
