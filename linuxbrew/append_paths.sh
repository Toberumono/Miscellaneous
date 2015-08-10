#Add Linuxbrew into PATH, MANPATH, and INFOPATH
bin_path='PATH="$HOME/.linuxbrew/bin:$PATH"'
man_path='MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"'
info_path='INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"'
should_reopen=""

update_rc() {
	add_bin=$(grep -F -e 'export '$bin_path "$1")
	add_man=$(grep -F -e 'export '$man_path "$1")
	add_info=$(grep -F -e 'export '$info_path "$1")

	if [ "$add_bin" == "" ] || [ "$add_man" == "" ] || [ "$add_info" == "" ]; then
		echo "" >> "$1"
		echo "# This adds the necessary Linuxbrew paths." >> "$1"
		should_reopen=$should_reopen"  $1"
	fi

	[ "$add_bin" == "" ]	&& echo "Adding 'export '$bin_path to $1" && echo 'export '$bin_path >> "$1" || echo "Linuxbrew is already added to PATH in $1"
	[ "$add_man" == "" ]	&& echo "Adding 'export '$man_path to $1" && echo 'export '$man_path >> "$1" || echo "Linuxbrew is already added to MANPATH in $1"
	[ "$add_info" == "" ]	&& echo "Adding 'export '$info_path to $1" && echo 'export '$info_path >> "$1" || echo "Linuxbrew is already added to INFOPATH in $1"
}

[ -e "$HOME/.bashrc" ] && update_rc "$HOME/.bashrc"

[ -e "$HOME/.zshrc" ] && update_rc "$HOME/.zshrc"

for var in "$@"
do
	[ -e "$var" ] && update_rc "$var"
done

if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please restart your terminal session for these changes to take effect (open a new window and close this one once you are done with the information in it)."
fi
