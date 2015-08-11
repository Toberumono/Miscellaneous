#Add Java into PATH and MANPATH
#Author: Toberumono (https://github.com/Toberumono)

jvm_path="$HOME/jvm"
jvm_current_path='$HOME/jvm/current'

client="JDK"
should_reopen=""

update_rc() {
	added=false
	file_path="${1}"
	shift
	for p in $@; do
		add_path=$(grep -F -e 'export '$p "$file_path")
		if [ "$add_path" != "" ]; then
			echo 'export '$p" is already in $file_path."
			continue;
		fi
		if ( ! $added ); then
			echo "" >> "$file_path"
			echo "# This adds the necessary $client paths." >> "$file_path"
			[ "$should_reopen" == "" ] && should_reopen="$file_path" || should_reopen=$should_reopen" $file_path"
			added=true
		fi
		echo "Adding export $p to $file_path."; echo 'export '$p >> "$file_path"
	done
}

paths=( 'PATH="'$jvm_current_path'/bin:$PATH"' 'MANPATH="'$jvm_current_path'/man:$MANPATH"' )

[ -e "$HOME/.bashrc" ] && update_rc "$HOME/.bashrc" "${paths[@]}"
[ -e "$HOME/.zshrc" ] && update_rc "$HOME/.zshrc" "${paths[@]}"

for var in "$@"; do
	[ -e "$var" ] && update_rc "$var" "${paths[@]}"
done

if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please restart your terminal session for these changes to take effect (open a new window and close this one once you are done with the information in it)."
fi
