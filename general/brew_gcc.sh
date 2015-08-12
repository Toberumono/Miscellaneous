#Brews gcc and sets the relevant environment variables in the profile file.
#Author: Toberumono (https://github.com/Toberumono)

brew install gcc
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

gfortran_version="$(gfortran -dumpversion | cut -d. -f1)"
[ "$gfortran_version" < 5 ] && gfortran_version="$(gfortran -dumpversion | cut -d. -f1,2)"

update_rc "Brewed gcc" "$profile" "HOMEBREW_CC=gcc-$gfortran_version" "HOMEBREW_FC=gfortran-$gfortran_version" "CC=$(which gcc)" "FC=$(which gfortran)"

for var in "$@"; do
	update_rc "$var" "HOMEBREW_CC=gcc-$gfortran_version" "HOMEBREW_FC=gfortran-$gfortran_version" "CC=$(which gcc)" "FC=$(which gfortran)"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session or run 'source $profile' for these changes to take effect."
fi
