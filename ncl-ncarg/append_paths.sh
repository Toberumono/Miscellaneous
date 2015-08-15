#Add Apache NCL-NGARG into NCARG_ROOT and PATH
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

ncl_path="$HOME/.ncl-ncarg"
ncl_current_path="$ncl_path/current"

path_path='PATH="'"$ncl_current_path"'/bin:$PATH"'

update_rc "NCL-NCARG" "$profile" $path_path "NCARG_ROOT=$ncl_current_path"

for var in "$@"; do
	update_rc "NCL-NCARG" "$var" $path_path "NCARG_ROOT=$ncl_current_path"
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
