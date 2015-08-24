#This script automatically downloads the latest version of ant, installs it
#in "$HOME/.ant", and adds the relevant exports to the appropriate shell profile file.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/unsudo.sh")

#Grab the most recent Ant version from the changelog.
ant_version_pattern='([0-9]+\.)*[0-9]+$'
ant_version="$( ($pull_command http://supergsego.com/apache//ant/README.html) | grep -E '^Changes' | grep -oE $ant_version_pattern)"
echo "Downloading Apache-Ant version $ant_version"

should_install=0
if [ "$(which ant)" != "" ]; then
	current_version="$(ant -version | grep -oE '^.*?([0-9]+\.)*[0-9]+' | grep -oE -m 1 '([0-9]+\.)*[0-9]+')"
	IFS='.' read -ra cv_arr <<< "$ant_version"
	IFS='.' read -ra av_arr <<< "$current_version"
	i="0"
	if [ "${#cv_arr[@]}" -ne "${#av_arr[@]}" ]; then
		should_install=2
	fi
	while [ "$should_install" -eq "0" ] && [ "$i" -lt "${#cv_arr[@]}" ]; do
		if [ "${cv_arr[$i]}" -gt "${av_arr[$i]}" ]; then
			echo "A newer version of Apache Ant (version $current_version) is already installed.  Please uninstall that version before re-running this script."
			exit 0
		elif [ "${cv_arr[$i]}" -lt "${av_arr[$i]}" ]; then
			should_install=1
		fi
		(( i = i + 1 ))
	done
else
	should_install=2
fi
if [ "$should_install" -eq "0" ]; then
	echo "Apache Ant version $current_version is already installed.  Nothing to do here.  Exiting."
	exit 0
elif [ "$should_install" -eq "1" ]; then
	echo "Updating Apache Ant version $current_version to version $ant_version."
else
	echo "Installing Apache Ant version $ant_version."
fi

ant_path="$HOME/.ant"
mkdir -p "$ant_path"

[ "$(which wget)" == "" ] && pull_command="curl -fSL" || pull_command="wget -O -" #We /definitely/ want a progress bar for this next command.
($pull_command "http://apache.mirrors.tds.net//ant/binaries/apache-ant-$ant_version-bin.tar.gz") | $unsudo tar -xz -C "$HOME/.ant"
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

ant_installed_path="$(ls -dt1 $ant_path/apache-ant* | head -1)"
ln -sf "$ant_installed_path" "$ant_path/current"
($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ant/append_paths.sh") | $unsudo bash
