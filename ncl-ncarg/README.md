# <a name="ncl"></a>NCL-NCARG
All of the files in this directory relate to [NCL-NCARG](https://www.ncl.ucar.edu/index.shtml), and generally automate a part of its installation.

## <a name="htunai"></a>How to use `automatic_install.sh`
**This script does not require sudo**

Run the following command in terminal (make sure you copy and paste all of it - this scrolls):
```bash
bash <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/automatic_install.sh")
```
The command downloads the `ncl-ncarg/automatic_install.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`ncl-ncarg/automatic_install.sh`) itself does the following:

1. Forwards to `ncl-ncarg/ncl_downloader.sh` to automatically determine the correct version of [NCL-NCARG](https://www.ncl.ucar.edu/index.shtml) and download it.
2. Forwards to `ncl-ncarg/sudoless_install.sh` to automatically install and link it.
3. Cleans up the temporary files (the .tar.gz file)
4. Done.  Just restart terminal to finish the linking process.

## <a name="htunnsi"></a>How to use `sudoless_install.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/sudoless_install.sh)
```
The command downloads the `ncl-ncarg/sudoless_install.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`ncl-ncarg/sudoless_install.sh`) itself does the following:

1. Creates `$HOME/.ncl-ncarg` if it does not exist
2. Gets the newest tarball in the directory in which it was called (the tarball *must* end with `.tar.gz`) that matches the NCL-NCARG filename format.
3. Confirms that it has the correct tarball with the user and:
  - Exits if it does not.
  + Proceeds to step 3 if it does.
4. Unpacks the tarball into `$HOME/.ncl-ncarg`.
  + NCL-NCARG tarballs do not have the version-specific folder in their root directory, so we create one.
5. Updates or creates a symlink called current in `$HOME/.ncl-ncarg` (`$HOME/.ncl-ncarg/current`) that points to the newest directory in the `$HOME/.ncl-ncarg` folder (the one in the tarball it just unpacked).
6. It internally downloads and executes the `ncl-ncarg/append_paths.sh` script in this repository (see [How to Use "append_paths.sh"](#htuaap) for more information on what that does).
  + It uses the same command given in the [How to Use `append_paths.sh`](#htuaap) section so it doesn't require the user to mess with temporary files.
  + `ncl-ncarg/append_paths.sh` is used to avoid creating a bunch of symlinks in /usr/bin which is bad practice, annoying to update, and requires sudo.

## <a name="htunnap"></a>How to Use `append_paths.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/ncl-ncarg/append_paths.sh)
```
The command downloads the `ncl-ncarg/append_paths.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`ncl-ncarg/append_paths.sh`) itself does the following:

1. Tests for the existence of the user's shell profile file (e.g. ~/.bashrc)
2. Tests if each of the following lines are in the file:
  + `export PATH="$HOME/.ncl-ncarg/current/bin:$PATH"`
  + `export NCARG_ROOT="$HOME/.ncl-ncarg/current"`
3. Appends the lines that are not in the file to the end of the file (This makes it safe to re-run)
4. Prints which lines it added and which ones it did not for each file
