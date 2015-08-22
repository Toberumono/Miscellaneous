#Add Linuxbrew into PATH, MANPATH, and INFOPATH
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

[ "$(which brew)" != "" ] && brewery_path="$(brew --prefix)" || brewery_path="$HOME/.linuxbrew"
path_path='export PATH="'$brewery_path'/bin:$PATH"'
man_path='export MANPATH="'$brewery_path'/share/man:$MANPATH"'
info_path='export INFOPATH="'$brewery_path'/share/info:$INFOPATH"'

[ "$(uname -s)" == "Darwin" ] && brewery="Homebrew" || brewery="Linuxbrew"
update_rc "$brewery" "$profile" "$path_path" "$man_path" "$info_path"

for var in "$@"; do
	update_rc "$brewery" "$var" "$path_path" "$man_path" "$info_path"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
