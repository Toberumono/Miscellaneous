#!/usr/bin/env bash
#A support function to determine the correct user to use when calling
#a step without sudo permissions from within a script run as sudo.
#Author: Toberumono (https://github.com/Toberumono)

[ $SUDO_USER ] && unsudo="sudo -u $SUDO_USER" || unsudo=""
