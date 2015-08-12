# <a name="General"></a>General
The files in this directory are not related to a single specific program, and are used in a variety of contexts.
Furthermore, they are almost exclusively used as libraries - there is almost no point in calling them on their own.

## <a name="unsudo"></a>How to Use `unsudo.sh`
### Usage
Executing this script from within another with
```bash
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/unsudo.sh")
```
will initialize a variable called `unsudo`.  If the script was run as sudo, it will equal `"sudo -u calling_user"` (e.g. `"sudo -u Toberumono"`).  Otherwise, it will equal `""`.<br>
In order to use `unsudo`, place it (`$unsudo`) before commands that should be run without `sudo` where `sudo` would normally be.<br>
This will use the `sudo -u calling_user` prefix if `sudo` was detected and no prefix if it was not.

### A few notes
* Attempting to use `sudo -u calling_user` without `sudo` permissions will result in an error.  Therefore, it is important to ensure that you only call it when necessary.
* This script can be run multiple times without negative effects because it overwrites the variable each time.
