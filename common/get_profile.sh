#Grabs the profile file for the current shell taking the OS into account (e.g. ~/.bashrc or ~/.bash_profile)
#Author: Toberumono (https://github.com/Toberumono)

shell_exec="$(ps -o comm= -p $$ | sed -e 's/-\{0,1\}\(.*\)/\1/' | grep -oE '[^/]*$')"
[ "$(uname -s)" == "Darwin" ] && profile="$HOME/.${shell_exec}_profile" || profile="$HOME/.${shell_exec}rc"
unset shell_exec