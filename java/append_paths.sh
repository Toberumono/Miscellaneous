#Add Java into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

#Download the update_rc.sh and get_profile.sh scripts from my repo and run their contents within the current shell via an anonymous file descriptor.
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

jvm_path="$HOME/.jvm"
jvm_current_path="$jvm_path/current"

path_path='PATH="'"$jvm_current_path"'/bin:$PATH"'
man_path='MANPATH="'"$jvm_current_path"'/man:$MANPATH"'

update_rc "JDK" "$profile" $path_path $man_path

for var in "$@"; do
	update_rc "JDK" "$var" $path_path $man_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
