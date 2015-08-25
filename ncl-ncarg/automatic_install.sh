#!/usr/bin/env bash
#Downloads the appropriate version of the NCL-NCARG tarball
#and installs it using ncl_downloader.sh and sudoless_install.sh.
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget --show-progress -qO -"

. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/ncl_downloader.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/sudoless_install.sh")
rm "$(pwd)/$ncl_tarball" #Cleanup
