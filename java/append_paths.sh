#Add Java into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

jvm_path="$HOME/jvm"
jvm_current_path='$HOME/jvm/current'

. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")

paths=( 'PATH="'$jvm_current_path'/bin:$PATH"' 'MANPATH="'$jvm_current_path'/man:$MANPATH"' )

[ -e "$HOME/.bashrc" ] && update_rc "JDK" "$HOME/.bashrc" "${paths[@]}"
[ -e "$HOME/.zshrc" ] && update_rc "JDK" "$HOME/.zshrc" "${paths[@]}"

for var in "$@"; do
	[ -e "$var" ] && update_rc "$var" "${paths[@]}"
done

if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please restart your terminal session for these changes to take effect (open a new window and close this one once you are done with the information in it)."
fi
