#Add Java into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

jvm_path="$HOME/.jvm"
jvm_current_path="$jvm_path/current"

path_path='PATH="$jvm_current_path/bin:$PATH"'
man_path='MANPATH="$jvm_current_path/man:$MANPATH"'

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

update_rc "JDK" "$profile" $path_path $man_path

for var in "$@"; do
	update_rc "JDK" "$var" $path_path $man_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
