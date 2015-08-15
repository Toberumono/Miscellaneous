#Install the most recent version of Apache Ant without sudo
#Author: Toberumono (https://github.com/Toberumono)

ant_path="$HOME/.ant"

mkdir -p "$ant_path"
ant_tar="$(ls $(pwd)/apache-ant* -t -1 | head -1)"
read -n1 -p "Installing Apache Ant in $ant_path using $ant_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$ant_tar" -C "$ant_path"

ant_path="$(ls -d $ant_path/apache-ant* -t -1 | head -1)"
ln -sf "$ant_path" "$ant_path/current"
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ant/append_paths.sh")