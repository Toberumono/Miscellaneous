#Install the most recent JDK without sudo
jvm_path="$HOME/jvm"

mkdir -p "$jvm_path"
jdk_tar="$(ls $(pwd)/jdk* -t -1 | head -1)"
read -p "Installing the JDK in $jdk_tar.  Proceed? [Press Enter to continue, press any other key to quit]" yn
if [ "$yn" != "" ]; then
	exit 0;
fi
tar -zxvf "$jdk_tar" -C "$jvm_path"

jdk_path="$(ls $jvm_path/jdk* -t -1 | head -1)"
echo "$jdk_path"
ln -sf "$jdk_path" "$jvm_path/current"
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/java/append_paths.sh")