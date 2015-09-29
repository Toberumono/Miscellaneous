#!/usr/bin/env bash
#Add Apache Ant into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

ant_path="$HOME/.ant"
ant_current_path="$ant_path/current"

path_path='export PATH="'"$ant_current_path"'/bin:$PATH"'

update_rc "Apache Ant" "$profile" "$path_path"

for var in "$@"; do
	update_rc "Apache Ant" "$var" "$path_path"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
