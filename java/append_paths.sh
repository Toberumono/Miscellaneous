#Add Java into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

jvm_path="$HOME/jvm"
jvm_current_path='$HOME/jvm/current'

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")

path_path='PATH="'$jvm_current_path'/bin:$PATH"'
man_path'MANPATH="'$jvm_current_path'/man:$MANPATH"'

shell="$(ps -o comm= -p $$ | sed -e 's/-\{0,1\}\(.*\)/\1/')"
if [ "$(uname -s)" == "Darwin" ]; then
	update_rc "JDK" "$HOME/.${shell}_profile" $path_path $man_path
else
	update_rc "JDK" "$HOME/.${shell}rc" $path_path $man_path
fi

for var in "$@"; do
	[ -e "$var" ] && update_rc "JDK" "$var" $path_path $man_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
