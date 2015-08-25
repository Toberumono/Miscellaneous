#!/usr/bin/env bash
#Adds the needed fallback path to the user's appropriate profile file.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget --show-progress -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

ncarg_root_path="export NCARG_ROOT=$(brew --prefix)/ncl-current"
path_path='export PATH=$NCARG_ROOT/bin:$PATH'
#This is basically just the command recommended in the caveats for the ncar-ncl cask in Homebrew.
fallback_path='export DYLD_FALLBACK_LIBRARY_PATH=$(dirname $(gfortran --print-file-name libgfortran.3.dylib)):$DYLD_FALLBACK_LIBRARY_PATH'

update_rc "Brewed NCAR-NCL" "$profile" "$ncarg_root_path" "$path_path" "$fallback_path"

for var in "$@"; do
	update_rc "Brewed NCAR-NCL" "$var" "$ncarg_root_path" "$path_path" "$fallback_path"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
