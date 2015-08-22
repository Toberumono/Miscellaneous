# <a name="General"></a>General
The files in this directory are not related to a single specific program, and are used in a variety of contexts.
Furthermore, they are almost exclusively used as libraries - there is almost no point in calling them on their own.

## <a name="unsudo"></a>How to use `unsudo.sh`
### Usage
Executing this script from within another script with
```bash
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/unsudo.sh")
```
will initialize a variable called `unsudo`.  If the script was run as sudo, it will equal `"sudo -u calling_user"` (e.g. `"sudo -u Toberumono"`).  Otherwise, it will equal `""`.<br>
In order to use `unsudo`, place `$unsudo` before commands that should be run without `sudo` where `sudo` would normally be.<br>
This will use the `sudo -u calling_user` prefix if `sudo` was detected and no prefix if it was not.

### A few notes
* Attempting to use `sudo -u calling_user` without `sudo` permissions will result in an error.  Therefore, it is important to ensure that you only call it when necessary.
* This script can be run multiple times without negative effects because it overwrites the variable each time.

## <a name="update_rc"></a>How to use `update_rc.sh`
This script is designed to be used to detect whether a export line is in a .shellrc file, and add the line to the file if it did not find it.

### Usage
Executing this script from within another script with
```bash
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/common/update_rc.sh")
```
will intialize a function called `update_rc()` which takes a 'client' (the name of the thing it is adding the lines for (e.g. JDK, Linuxbrew), a path to a file, and one or lines to add to the file.<br>
This function adds any filenames that it had to add lines to to a variable called `should_reopen`, which is set to `""` when the `update_rc.sh` script is run.

### A few notes
* The arguments *must* be given in the order listed (client, file, paths).
* paths *can* be an array; however, because arrays are piped into the arguments list upon being passed, this is optional.
* This script can be run multiple times without negative effects because it overwrites the variable each time.
