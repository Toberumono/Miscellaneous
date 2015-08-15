# <a name="ant"></a>Apache Ant
All of the files in this directory relate to [Apache Ant](http://ant.apache.org/index.html), and generally automate a part of its installation.

## <a name="htuasi"></a>How to use `sudoless_install.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ant/sudoless_install.sh)
```
The command downloads the `ant/sudoless_install.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`ant/sudoless_install.sh`) itself does the following:

1. Creates `$HOME/.ant` if it does not exist
2. Gets the newest tarball in the directory in which it was called (the tarball *must* end with `.tar.gz`) that matches the Ant filename format.
3. Confirms that it has the correct tarball with the user and:
  - Exits if it does not.
  + Proceeds to step 3 if it does.
4. Unpacks the tarball into `$HOME/.ant`.
  + Ant tarballs have the version-specific folder in their root directory, so we don't need to worry about creating it.
5. Updates or creates a symlink called current in `$HOME/.ant` (`$HOME/.ant/current`) that points to the newest directory in the `$HOME/.ant` folder (the one in the tarball it just unpacked).
6. It internally downloads and executes the `ant/append_paths.sh` script in this repository (see [How to Use "append_paths.sh"](#htuaap) for more information on what that does).
  + It uses the same command given in the [How to Use `append_paths.sh`](#htuaap) section so it doesn't require the user to mess with temporary files.
  + `ant/append_paths.sh` is used to avoid creating a bunch of symlinks in /usr/bin which is bad practice, annoying to update, and requires sudo.

## <a name="htuaap"></a>How to Use `append_paths.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ant/append_paths.sh)
```
The command downloads the `ant/append_paths.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`ant/append_paths.sh`) itself does the following:

1. Tests for the existence of the user's shell profile file (e.g. ~/.bashrc)
2. Tests if each of the following lines are in the file:
  + `export PATH="$HOME/.ant/current/bin:$PATH"`
3. Appends the lines that are not in the file to the end of the file (This makes it safe to re-run)
4. Prints which lines it added and which ones it did not for each file
