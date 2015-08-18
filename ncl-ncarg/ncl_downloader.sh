#Detects the appropriate ncl_tarball to download using the current_ncl-ncarg_versions.csv file.
#If it cannot determine a single archive, it asks the user which one they want.
#Last, it downloads the archive to the current working directory.
#Author: Toberumono (https://github.com/Toberumono)
[ "$(which wget)" == "" ] && pull_command="curl -fsSL" || pull_command="wget -qO -"

os_ver=""
if [ "$(uname -s)" == "Darwin" ]; then #We are running on a Mac
	os_ver="MacOS_$(sw_vers -productVersion | grep -o -E '^[0-9]+\.[0-9]+')"
elif [ "$(uname -o)" == "GNU/Linux" ]; then #We are running on a Linux box
	os_ver="Linux_"
	if [ "$(ls /etc/debian*)" != "" ]; then
		os_ver="${os_ver}Debian"
		[ "$(uname -p | grep 'i686')"] && os_ver="${os_ver}.*i686" || os_ver="${os_ver}.*x86_64"
	elif [ "$(ls /etc/redhat*)" != "" ]; then
		os_ver="${os_ver}RHEL"
		[ "$(uname -p | grep 'i686')"] && os_ver="${os_ver}.*i686" || os_ver="${os_ver}.*x86_64"
		[ "$(which gcc)" == "" ] && os_ver="${os_ver}.*intel"
	fi
elif [ "$(uname -o)" == "Cygwin" ]; then
	os_ver="CYGWIN"
fi
[ "$(uname -s)" == "Darwin" ] && sed_ext="-E" || sed_ext="-r" #The extended pattern argument for sed is different on Macs

pairs=()
while read -r line; do
	pairs+=($(echo $line | sed 's/['\'',]//g'))
done <($pull_command "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/current_ncl-ncarg_versions.csv")

options=()
paths=()
#The current gcc version is always at the end of the first line. So, we take advantage of that to anchor the pattern in grep.
gcc_ver="$(gcc --version | grep -oE '([0-9]+\.)*[0-9]\s*$' | sed 's/\.//g')"
min_diff=""
i="0"
while [ "$i" -lt "${#pairs[@]}" ]; do
	(( j = i + 1 ))
	archive="$(echo ${pairs[$i]} | grep -E $os_ver | sed $sed_ext 's/^'\''([^'\'']+)'\''.*/\1/g')"
	if [ "$archive" != "" ]; then
		arch_ver="$(echo $archive | sed $sed_ext 's/.*gcc(.*)\.tar\.gz/\1/' | sed $sed_ext 's/\.//g')"
		(( diff = gcc_ver - arch_ver ))
		diff="${diff/#-/}" #Absolute value
		if [ "$min_diff" == "" ] || [ "$min_diff" -gt "$diff" ]; then
			options=("${pairs[$i]}")
			paths=("${pairs[$j]}")
			min_diff="$diff"
		elif [ "$min_diff" -eq "$diff" ]; then
			options+=("${pairs[$i]}")
			paths+=("${pairs[$j]}")
		fi
	fi
	(( i = j + 1 ))
done

#If we were unable to perform any detection.
if [ "${#options[@]}" -eq "0" ]; then
	i="0"
	while [ "$i" -lt "${#pairs[@]}" ]; do
		options=("${pairs[$i]}")
		(( i = i + 1 ))
		paths=("${pairs[$i]}")
		(( i = i + 1 ))
	done
fi

if [ "${#options[@]}" -gt "1" ]; then
	echo "Unable to determine the correct ncl_tarball for your system."
	echo "Possible matches are:"
	i="0"
	while [ "$i" -lt "${#options[@]}" ]; do
		(( j = i + 1 ))
		echo "$j. ${options[$i]}"
		i="$j"
	done
	echo "Please select the ncl_tarball that most closely matches your system."
	echo "If you are unsure, picking the one with the largest number between gcc and .tar.gz should work."
	read -p "Type the number next to the one that you want to select and press enter: " num
	ncl_tarball="${options[$num]}"
	path="${paths[$num]}"
elif [ "${#options[@]}" -eq "1" ]; then
	ncl_tarball="${options[0]}"
	path="${paths[0]}"
fi

echo "Using: $ncl_tarball"

wget -O "$(pwd)$ncl_tarball" "$path"
