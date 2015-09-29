#!/usr/bin/env bash
#Install the most recent version of NCL-NCARG without sudo
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget -qO -"

ncl_tar="$(ls -t1 $(pwd)/ncl_ncarg* | head -1)"
ncl_path="$HOME/.ncl-ncarg"
ncl_installed_path="$ncl_path/$(echo $ncl_tar | grep -oE 'ncl_ncarg-([0-9]+\.)*[0-9]+')"

mkdir -p "$ncl_installed_path"
read -n1 -p "Installing NCL-NCARG in $ncl_path using $ncl_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$ncl_tar" -C "$ncl_installed_path"

ln -sf "$ncl_installed_path" "$ncl_path/current"
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/append_paths.sh")

echo "Now testing your new NCL-NCARG installation."
if [ "$(ncargex cpex08 -clean | grep -F -e 'dyld: Library not loaded')" != "" ]; then
	echo "Attempting to repair your paths."
	bash <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/brewed_path_fix.sh")
	source "$profile"
	if [ "$(ncargex cpex08 -clean | grep -F -e 'dyld: Library not loaded')" != "" ]; then
		echo "Repairs failed.  Unable to successfully link all libraries.  Please see the NCL website for further help."
	else
		echo "Repairs succeeded!"
	fi
else
	echo "Success!"
fi
