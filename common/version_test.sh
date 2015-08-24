#Determines whether a given program is up to date given the installed version and the available version.
#Author: Toberumono (https://github.com/Toberumono)

#Takes the following arguments:
#  1: the current version as a string (numbers separated by '.')
#  2: the available version as a string (numbers separated by '.')
#Returns: 0 if the current version is newer than the available version
#           or it's version code is longer
#         1 if the versions are equal
#         2 if the available version is newer than the current version
#           or it's version code is longer
#All Returns occur via echo
version_test() {
	local cv_arr=""
	local av_arr=""
	IFS='.' read -ra cv_arr <<< "$1"
	IFS='.' read -ra av_arr <<< "$2"
	local i="0"
	[ "${#cv_arr[@]}" -gt "${#av_arr[@]}" ] && local lim="${#cv_arr[@]}" || local lim="${#av_arr[@]}"
	while [ "$i" -lt "lim" ]; do
		if [ "${cv_arr[$i]}" -gt "${av_arr[$i]}" ]; then
			echo "0"
			return 0;
		elif [ "${cv_arr[$i]}" -lt "${av_arr[$i]}" ]; then
			echo "2"
			return 0;
		fi
		(( i = i + 1 ))
	done
	if [ "${#cv_arr[@]}" -gt "${#av_arr[@]}" ]; then
		echo "0"
		return 0;
	elif [ "${#cv_arr[@]}" -lt "${#av_arr[@]}" ]; then
		echo "2"
		return 0;
	else
		echo "1"
		return 0;
	fi
}