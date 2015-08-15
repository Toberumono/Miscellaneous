#Install the most recent version of NCL-NCARG without sudo
#Author: Toberumono (https://github.com/Toberumono)

ncl_tar="$(ls $(pwd)/ncl_ncarg* -t -1 | head -1)"
ncl_path="$HOME/.ncl-ncarg/$(echo $ncl_tar | grep -oE 'ncl_ncarg-([0-9]+\.)*[0-9]+')"

mkdir -p "$ncl_path"
read -n1 -p "Installing NCL-NCARG in $ncl_path using $ncl_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$ncl_tar" -C "$ncl_path"

ncl_installed_path="$(ls -d $ncl_path/ncl* -t -1 | head -1)"
ln -sf "$ncl_installed_path" "$ncl_path/current"
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/append_paths.sh")