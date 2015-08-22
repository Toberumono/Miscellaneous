#A support function used to append export commands to .bashrc, .zshrc, etc.
#Author: Toberumono (https://github.com/Toberumono)

[ $SUDO_USER ] && unsudo="sudo -u $SUDO_USER" || unsudo=""
