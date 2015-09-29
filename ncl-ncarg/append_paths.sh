#!/usr/bin/env bash
#Add Apache NCL-NGARG into NCARG_ROOT and PATH
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/get_profile.sh")

ncl_path="$HOME/.ncl-ncarg"
ncl_current_path="$ncl_path/current"

root_path="NCARG_ROOT=$ncl_current_path"
path_path='PATH="$NCARG_ROOT/bin:$PATH"'
#This takes the command recommended in caveats section of Homebrew's ncar-ncl cask
#And creates aliases for each of the ncar-ncl executables with that command on the front.
#We use aliases instead of exporting the command because exporting it can cause some serious problems with Homebrew.
ncl_alias='while IFS= read -r line; do alias "$line"="DYLD_FALLBACK_LIBRARY_PATH=$(dirname $(gfortran --print-file-name libgfortran.3.dylib)):"'\''$DYLD_FALLBACK_LIBRARY_PATH'\''" $line"; done < <(ls -1 "$NCARG_ROOT/bin")'

export "$root_path"
export "PATH=$NCARG_ROOT/bin:$PATH"

if [ "$(uname -s)" == "Darwin" ]; then
	export "$fallback_path"
	update_rc "NCL-NCARG" "$profile" "$root_path" "$path_path" "$ncl_alias"

	for var in "$@"; do
		update_rc "NCL-NCARG" "$var" "$root_path" "$path_path" "$ncl_alias"
	done
else
	update_rc "NCL-NCARG" "$profile" "$root_path" "$path_path"

	for var in "$@"; do
		update_rc "NCL-NCARG" "$var" "$root_path" "$path_path"
	done
fi

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
