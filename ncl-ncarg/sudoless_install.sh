#Install the most recent version of NCL-NCARG without sudo
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

ncl_tar="$(ls $(pwd)/ncl_ncarg* -t -1 | head -1)"
ncl_path="$HOME/.ncl-ncarg"
ncl_installed_path="$ncl_path/$(echo $ncl_tar | grep -oE 'ncl_ncarg-([0-9]+\.)*[0-9]+')"

mkdir -p "$ncl_installed_path"
read -n1 -p "Installing NCL-NCARG in $ncl_path using $ncl_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$ncl_tar" -C "$ncl_path"

ln -sf "$ncl_installed_path" "$ncl_path/current"
bash <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/append_paths.sh")