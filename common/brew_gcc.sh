#!/usr/bin/env bash
#Brews gcc and sets the relevant environment variables in the profile file.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget --show-progress -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

brew install gcc

ver="$(gfortran -dumpversion | cut -d. -f1)"
if [ "$ver" -lt "5" ]; then
	ver="$(gfortran -dumpversion | cut -d. -f1,2)"
fi

update_rc "Brewed gcc" "$profile" "CC=$(which gcc-$ver)" "CXX=$(which g++-$ver)" "FC=$(which gfortran)"

for var in "$@"; do
	update_rc "Brewed gcc" "$var" "CC=$(which gcc-$ver)" "CXX=$(which g++-$ver)" "FC=$(which gfortran)"
done

#The should_reopen variable is added by the update_rc.sh script.
[ "$should_reopen" == "$profile" ] && source "$profile"
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session or run 'source $profile' for these changes to take effect."
fi
