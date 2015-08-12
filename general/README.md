# <a name="General"></a>General
The files in this directory are not related to a single specific program, and are used in a variety of contexts.
Furthermore, they are almost exclusively used as libraries - there is almost no point in calling them on their own.

## <a name="unsudo"></a>How to Use `unsudo.sh`
Executing this script from within another with
```bash
. <(wget -qO - "https://raw.githubusercontent.com/Toberumono/Miscellaneous/master/general/unsudo.sh")
```
Will initialize a variable called `unsudo`.  If the script was run as sudo, it will equal `"sudo -u calling_user"` (e.g. `"sudo -u Toberumono"`).  Otherwise, it will equal `""`.
If you have a script that runs as sudo, but contains commands that should not run as sudo, placing `$unsudo` at the start of the command (where you would normally place `sudo`) will use the `sudo -u calling_user` prefix, thereby making it not run as sudo.  Otherwise, it won't use any prefix, thereby preventing permissions issues in both cases.
Because `unsudo` is not returned, it can be used multiple times.  Furthermore, this script can be run multiple times without negative effects because it overwrites the variable each time.
