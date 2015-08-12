# <a name="linuxbrew"></a>Linuxbrew
All of the files in this directory relate to [Linuxbrew](https://github.com/Homebrew/linuxbrew), and generally automate a part of its installation.

## <a name="htulai"></a>How to use `automatic_install.sh`
**This is a Linux-only script.**
**This script requires sudo.**

Run the following command in terminal (make sure you copy and paste all of it (note this is a bit different from the others)):
```bash
(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/automatic_install.sh") | sudo bash
```
The command downloads the `linuxbrew/automatic_install.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`linuxbrew/automatic_install.sh`) itself does the following:

1. Determines the correct system package manager (either `apt-get` or `yum`)
  * If it cannot find either one, it will attempt to complete the install; however, this comes with the caveats enumerated in the [How to use `sudoless_install.sh`](#htulsi) section.
2. Runs the appropriate support-software install command from the [Linuxbrew](https://github.com/Homebrew/linuxbrew) installation instructions.
3. It internally downloads and executes the `general/unsudo.sh` script from this repository to determine the original user.
4. It internally downloads and executes the `linuxbrew/sudoless_install.sh` script from this repository using the result from `general/unsudo.sh`.
  + It uses the pipe version of the command given in the [How to Use `sudoless_install.sh`](#htulsi) section so it doesn't require the user to mess with temporary files.
  + `linuxbrew/sudoless_install.sh` is used because it already performs all of the correct steps to test if it can install Linuxbrew and then installs it.

## <a name="htulsi"></a>How to use `sudoless_install.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/sudoless_install.sh)
```
The command downloads the `linuxbrew/sudoless_install.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`linuxbrew/sudoless_install.sh`) itself does the following:

1. Tests for `curl`, `ruby`, and `git` and
  1. If it cannot find all of them, it fails and prints which ones are missing.
  2. Otherwise, it runs:

    ```bash
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
    ```
3. It internally downloads and executes the `linuxbrew/append_paths.sh` script in this repository (see [How to Use "append_paths.sh"](#htulap) for more information on what that does).
  + It uses the same command given in the [How to Use `append_paths.sh`](#htulap) section so it doesn't require the user to mess with temporary files.
  + `linuxbrew/append_paths.sh` is used to avoid creating a bunch of symlinks in /usr/bin which is bad practice, annoying to update, and requires sudo.
4. It taps homebrew/dupes
5. It tests for `curl`, `bzip2`, `zlib`, `m4`, `texinfo`, `expat`, `ncurses`, `gcc`, and (for compatibility with my WRF scripts) `gfortran` and installs whichever ones it cannot find.

## <a name="htulap"></a>How to Use `append_paths.sh`
**This is a Linux-only script.**

Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/append_paths.sh)
```
The command downloads the `linuxbrew/append_paths.sh` script from this repository, pipes it into bash, and executes it.  Additionally, the command automatically cleans up the temporary "file" after it is done.
The script (`linuxbrew/append_paths.sh`) itself does the following:

1. Tests for the existence of ~/.bashrc and ~/.zshrc
  + Note: the remaining steps apply to whichever of the files exists (or both if they both exist)
2. Tests if each of the following lines are in the file:
  + `export PATH="$HOME/.linuxbrew/bin:$PATH"`
  + `export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"`
  + `export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"`
3. Appends the lines that are not in the file to the end of the file (This makes it safe to re-run)
4. Prints which lines it added and which ones it did not for each file
