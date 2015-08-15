#Add Apache Ant into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

ant_path="$HOME/.ant"
ant_current_path="$ant_path/current"

path_path='PATH="'"$ant_current_path"'/bin:$PATH"'

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

update_rc "Apache Ant" "$profile" $path_path

for var in "$@"; do
	update_rc "Apache Ant" "$var" $path_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
