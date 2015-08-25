#Install the most recent version of Apache Ant without sudo
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget --show-progress -qO -"

ant_path="$HOME/.ant"

mkdir -p "$ant_path"
ant_tar="$(ls -t1 $(pwd)/apache-ant* | head -1)"
read -n1 -p "Installing Apache Ant in $ant_path using $ant_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$ant_tar" -C "$ant_path"

ant_installed_path="$(ls -dt1 $ant_path/apache-ant* | head -1)"
ln -sf "$ant_installed_path" "$ant_path/current"
bash <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ant/append_paths.sh")