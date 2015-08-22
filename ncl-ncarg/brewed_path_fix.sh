#Adds the needed fallback path to the user's appropriate profile file.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")
#Okay, this line is /really/ long.  Basically, on Darwin systems (OSX), this gets the path to the libgfortran.3.dylib's containing folder.  This should /not/ be called on Linux systems.
#This basically takes advantage of a pattern in how the gfortran executable is linked by Homebrew.  It should work with other installations, and, even if it doesn't, it won't break them.
#This also has the advantage of automatically picking the library from whichever build of gfortran is currently in use.
fallback_path='export DYLD_FALLBACK_LIBRARY_PATH="$(echo $(echo $(echo $(which gfortran | sed "s/\/[^\/]*$/\//")$(readlink $(which gfortran)) | sed "s/\/[^\/]*$/\//")../lib/gcc/$(readlink $(which gfortran | sed "s/\/[^\/]*$/\//")$(readlink $(which gfortran)) | grep -oE '\''([0-9]+\.)*[0-9]+$'\'')) | sed '\''s/\([^\/]*\)\/\.\.\///g'\''):$DYLD_FALLBACK_LIBRARY_PATH"'

ncl_current="$(brew --prefix)/ncl-current"
ncarg_root_path="export NCARG_ROOT=$ncl_current"
path_path='export Path=$NCARG_ROOT/bin:$PATH'

update_rc "Brewed NCAR-NCL" "$profile" "$ncarg_root_path" "$path_path" "$fallback_path"

for var in "$@"; do
	update_rc "Brewed NCAR-NCL" "$var" "$ncarg_root_path" "$path_path" "$fallback_path"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
