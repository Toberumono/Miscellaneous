#Brews gcc and sets the relevant environment variables in the profile file.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

brew install gcc
gfortran_version="$(gfortran -dumpversion | cut -d. -f1)"
if [ "$gfortran_version" -lt "5" ]; then
	gfortran_version="$(gfortran -dumpversion | cut -d. -f1,2)"
fi
ln -sf "$(which gcc-$gfortran_version)" "$(brew --prefix)/bin/gcc"
ln -sf "$(which g++-$gfortran_version)" "$(brew --prefix)/bin/g++"
update_rc "Brewed gcc" "$profile" "CC=$(which gcc)" "CXX=$(which g++)" "FC=$(which gfortran)"

for var in "$@"; do
	update_rc "Brewed gcc" "$var" "CC=$(which gcc)" "CXX=$(which g++)" "FC=$(which gfortran)"
done

#The should_reopen variable is added by the update_rc.sh script.
[ "$should_reopen" == "$profile" ] && source "$profile"
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session or run 'source $profile' for these changes to take effect."
fi
