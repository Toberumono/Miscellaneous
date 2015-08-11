#Add Java into PATH and MANPATH
jvm_path="$HOME/jvm"
jvm_current_path='$HOME/jvm/current'

client="JDK"
should_reopen=""

update_rc() {
	added=false
	for p in ${2[@]}; do
		add_path=$(grep -F -e 'export '$p "$1")
		if ( ! $add_path); then
			echo 'export '$p" is already in $1"
			continue;
		fi
		if ( ! $added ); then
			echo "" >> "$1"
			echo "# This adds the necessary $client paths." >> "$1"
			[ "$should_reopen" == "" ] && should_reopen="$1" || should_reopen=$should_reopen" $1"
			added=true
		fi
		echo "Adding 'export '$p to $1"; echo 'export '$p >> "$1"
	done
}

jdk_path="$(ls $jvm_path/jdk* -t -1 | head -1)"
ln -sfr "$jdk_path" "$jvm_path/current"

paths=( 'PATH="'$jvm_current_path'/bin:$PATH"' 'MANPATH="'$jvm_current_path'/man:$MANPATH"' )

[ -e "$HOME/.bashrc" ] && update_rc "$HOME/.bashrc" $paths
[ -e "$HOME/.zshrc" ] && update_rc "$HOME/.zshrc" $paths

for var in "$@"; do
	[ -e "$var" ] && update_rc "$var" $paths
done

if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please restart your terminal session for these changes to take effect (open a new window and close this one once you are done with the information in it)."
fi
