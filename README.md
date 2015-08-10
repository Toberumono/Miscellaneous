# Miscellaneous
A collection of potentially useful scripts and support files that don't fit into my other projects

## <a name="linuxbrew"></a>Linuxbrew
All of the files in this directory relate to linuxbrew, a generally automate a part of its installation.

### <a name="htulsi"></a>How to use "sudoless_install.sh"
Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/sudoless_install.sh)
```
The command downloads the `linuxbrew/sudoless_install.sh` script from this repository, pipes it into bash, and executes it.
The script (`linuxbrew/sudoless_install.sh`) itself does the following:

1. Tests for `ruby` and `git` and
    1. If it cannot find either of them, it fails and prints which ones are missing.
    2. Otherwise, it proceeds.
2. Tests for curl and
  1. If it finds curl, installs [Linuxbrew](https://github.com/Homebrew/linuxbrew) via their main installation command:

    ```bash
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
    ```
  2. If it cannot find curl, it "installs" [Linuxbrew](https://github.com/Homebrew/linuxbrew) via a git-clone call:

    ```bash
    git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew
    ```
3. It calls the `linuxbrew/append_paths.sh` script in this repository (see [How to Use "append_paths.sh"](#htuah) for more information on what that does).
4. It taps homebrew/dupes
5. It tests for `curl`, `bzip2`, `zlib`, `m4`, `texinfo`, `expat`, `ncurses`, `gcc`, and (for compatibility with my WRF scripts) `gfortran` and installs whichever ones it cannot find.

---------------------------------

### <a name="htulap"></a>How to Use "append_paths.sh"
Run the following command in terminal (make sure you copy and paste all of it):
```bash
bash <(wget -qO - https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/linuxbrew/append_paths.sh)
```
The command downloads the `linuxbrew/append_paths.sh` script from this repository, pipes it into bash, and executes it.
The script (`linuxbrew/append_paths.sh`) itself does the following:

1. Tests for the existence of ~/.bashrc and ~/.zshrc
  + Note: the remaining steps apply to whichever of the files exists (or both if they both exist)
2. Tests if each of the following lines are in the file:
  + `export PATH="$HOME/.linuxbrew/bin:$PATH"`
  + `export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"`
  + `export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"`
3. Appends the lines that are not in the file to the end of the file (This makes it safe to re-run)
4. Prints which lines it added and which ones it did not for each file
