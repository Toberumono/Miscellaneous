#Install the most recent JDK without sudo
#Author: Toberumono (https://github.com/Toberumono)

jvm_path="$HOME/.jvm"

mkdir -p "$jvm_path"
jdk_tar="$(ls $(pwd)/jdk* -t -1 | head -1)"
read -n1 -p "Installing the JDK in $jvm_path using $jdk_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	exit 1
fi
tar -zxvf "$jdk_tar" -C "$jvm_path"

jdk_path="$(ls -d $jvm_path/jdk* -t -1 | head -1)"
ln -sf "$jdk_path" "$jvm_path/current"
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/java/append_paths.sh")