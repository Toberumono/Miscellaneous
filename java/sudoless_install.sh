#!/usr/bin/env bash
#Install the most recent JDK without sudo
#Author: Toberumono (https://github.com/Toberumono)

#Get the command to use when grabbing subscripts from GitHub.
[ "$(which wget)" == "" ] && pull_command="curl -#fsSL" || pull_command="wget --show-progress -qO -"

jvm_path="$HOME/.jvm"

mkdir -p "$jvm_path"
jdk_tar="$(ls -t1 $(pwd)/jdk* | head -1)"
read -n1 -p "Installing the JDK in $jvm_path using $jdk_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	echo "" #Echo a newline for neatness' sake
	exit 1
fi
tar -zxvf "$jdk_tar" -C "$jvm_path"

rm "$jvm_path/current"
jdk_path="$(ls -dt1 $jvm_path/jdk* | head -1)"
ln -sf "$jdk_path" "$jvm_path/current"
bash <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/java/append_paths.sh")
