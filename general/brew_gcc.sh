#Brews gcc and sets the relevant environment variables in the profile file.
#Author: Toberumono (https://github.com/Toberumono)

brew install gcc
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

gfortran_version="$(gfortran -dumpversion | cut -d. -f1)"
if [ "$gfortran_version" -lt "5" ]; then
	gfortran_version="$(gfortran -dumpversion | cut -d. -f1,2)"
fi
ln -sf "$(which gcc-$gfortran_version)" "$(brew --prefix)/bin/gcc"
ln -sf "$(which g++-$gfortran_version)" "$(brew --prefix)/bin/g++"
update_rc "Brewed gcc" "$profile" "HOMEBREW_CC=gcc-$gfortran_version" "HOMEBREW_FC=gfortran-$gfortran_version" "CC=$(which gcc)" "CXX=$(which g++)" "FC=$(which gfortran)"

for var in "$@"; do
	update_rc "Brewed gcc" "$var" "HOMEBREW_CC=gcc-$gfortran_version" "HOMEBREW_FC=gfortran-$gfortran_version" "CC=$(which gcc)" "CXX=$(which g++)" "FC=$(which gfortran)"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" == "$profile" ]; then
	source "$profile"
fi
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session or run 'source $profile' for these changes to take effect."
fi
