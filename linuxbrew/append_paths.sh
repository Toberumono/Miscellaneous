#Add Linuxbrew into PATH, MANPATH, and INFOPATH
#Author: Toberumono (https://github.com/Toberumono)

linuxbrew_path='$HOME/.linuxbrew'
path_path='PATH="'$linuxbrew_path'/bin:$PATH"'
man_path='MANPATH="'$linuxbrew_path'/share/man:$MANPATH"'
info_path='INFOPATH="'$linuxbrew_path'/share/info:$INFOPATH"'

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")

[ -e "$HOME/.bashrc" ] && update_rc "Linuxbrew" "$HOME/.bashrc" $path_path $man_path $info_path
[ -e "$HOME/.zshrc" ] && update_rc "Linuxbrew" "$HOME/.zshrc" $path_path $man_path $info_path

for var in "$@"; do
	[ -e "$var" ] && update_rc "$var" $path_path $man_path $info_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
