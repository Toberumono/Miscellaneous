#Add Linuxbrew into PATH, MANPATH, and INFOPATH
#Author: Toberumono (https://github.com/Toberumono)

[ "$(which brew)" != "" ] && linuxbrew_path="$(brew --prefix)" || linuxbrew_path='$HOME/.linuxbrew'
path_path='PATH="'$linuxbrew_path'/bin:$PATH"'
man_path='MANPATH="'$linuxbrew_path'/share/man:$MANPATH"'
info_path='INFOPATH="'$linuxbrew_path'/share/info:$INFOPATH"'

#Download the update_rc.sh script from my repo and run its contents within the current shell via an anonymous file descriptor.
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/update_rc.sh")
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/get_profile.sh")

[ "$(uname -s)" == "Darwin" ] && brewery="Homebrew" || brewery="Linuxbrew"
update_rc "$brewery" "$profile" $path_path $man_path $info_path

for var in "$@"; do
	update_rc "$brewery" "$var" $path_path $man_path $info_path
done

#The should_reopen variable is added by the update_rc.sh script.
if [ "$should_reopen" != "" ]; then
	echo "Modified: $should_reopen"
	echo "Please start a new terminal session for these changes to take effect."
fi
