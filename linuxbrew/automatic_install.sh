#This script requires sudo privileges
#Author: Toberumono (https://github.com/Toberumono)

if [ "$(which brew)" != "" ]; then
	echo "Linuxbrew is already installed."
	exit 0
fi

if [ "$(which apt-get)" != "" ]; then
	apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
elif [ "$(which yum)" != "" ]; then
	yum groupinstall 'Development Tools' && yum install curl git irb m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
else
	echo "Unable to find a valid package manager.  Attempting to proceed."
fi

. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/unsudo.sh")
(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/sudoless_install.sh") | $unsudo bash
