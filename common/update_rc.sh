#!/usr/bin/env bash
#A support function used to append export commands to .bashrc, .zshrc, etc.
#At this point, it can be used for any command on any file, but, it's mainly used for appending export commands.
#Author: Toberumono (https://github.com/Toberumono)

should_reopen=""

update_rc() {
	local client="$1"
	shift
	local file_path="$1"
	shift

	local added=false

	for p in "$@"; do
		local add_path=$(grep -F -e "$p" "$file_path")
		if [ "$add_path" != "" ]; then
			echo "$p is already in $file_path."
			continue;
		fi
		if ( ! $added ); then
			echo "" >> "$file_path"
			echo "# This adds the necessary $client paths." >> "$file_path"
			[ "$should_reopen" == "" ] && should_reopen="$file_path" || should_reopen=$should_reopen" $file_path"
			added=true
		fi
		echo "Adding $p to $file_path."; echo "$p" >> "$file_path"
	done
}
